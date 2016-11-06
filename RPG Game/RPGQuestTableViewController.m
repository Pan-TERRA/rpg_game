//
//  RPGQuestTableController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/31/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestTableViewController.h"
#import "RPGQuestListViewController.h"
#import "RPGQuestListTableViewCell.h"
#import "RPGQuestListState.h"
#import "RPGNibNames.h"
#import "RPGQuest.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGQuestRequest.h"
#import "RPGNetworkManager+Quests.h"

CGFloat const kRPGQuestListViewControllerRefreshIndicatorOffset = -30;

@interface RPGQuestTableViewController ()

@property(nonatomic, assign, readwrite, getter=canUpdateWhenScrollTable) BOOL updateWhenScrollTable;

@end

@implementation RPGQuestTableViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    _takeQuestsMutableArray = [[NSMutableArray alloc] init];
    _inProgressQuestsMutableArray = [[NSMutableArray alloc] init];
    _doneQuestsMutableArray = [[NSMutableArray alloc] init];
    _updateWhenScrollTable = YES;
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_takeQuestsMutableArray release];
  [_inProgressQuestsMutableArray release];
  [_doneQuestsMutableArray release];
  
  [super dealloc];
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
  if (aScrollView.contentOffset.y < kRPGQuestListViewControllerRefreshIndicatorOffset)
  {
    if (self.canUpdateWhenScrollTable)
    {
      self.updateWhenScrollTable = NO;
      
      [self.questListViewController updateViewForState:self.questListState willReload:NO];
    }
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  self.updateWhenScrollTable = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate
{
  // triggered only after refresh scroll
  if (!self.canUpdateWhenScrollTable)
  {
    [aScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
  }
}

#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
  NSUInteger result = 0;
  switch (self.questListState)
  {
    case kRPGQuestListTakeQuest:
    {
      result = [self.takeQuestsMutableArray count];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      result = [self.inProgressQuestsMutableArray count];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      result = [self.doneQuestsMutableArray count];
      break;
    }
    default:
    {
      break;
    }
  }
  return result;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGQuestListTableViewCell *cell = (RPGQuestListTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:kRPGQuestListTableViewCellNIBName];
  
  if (cell == nil)
  {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kRPGQuestListTableViewCellNIBName
                                                 owner:self
                                               options:nil];
    cell = [nib firstObject];
  }
  
  cell.backgroundColor = [UIColor clearColor];
  cell.backgroundView = [[UIView new] autorelease];
  cell.selectedBackgroundView = [[UIView new] autorelease];
  
  switch (self.questListState)
  {
    case kRPGQuestListTakeQuest:
    {
      [cell setCellContent:[self.takeQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      [cell setCellContent:[self.inProgressQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [cell setCellContent:[self.doneQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    default:
    {
      break;
    }
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  return 200;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  switch (self.questListState)
  {
    case kRPGQuestListTakeQuest:
    {
      [self.questListViewController showQuestViewWithQuest:[self.takeQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      [self.questListViewController showQuestViewWithQuest:[self.inProgressQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [self.questListViewController showQuestViewWithQuest:[self.doneQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    default:
    {
      break;
    }
  }
}

#pragma mark - Delete On Swipe

- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  return YES;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)anEditingStyle forRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  if (anEditingStyle == UITableViewCellEditingStyleDelete)
  {
    RPGQuestListState state = self.questListState;
    NSUInteger questID = [self getQuestIDByState:state index:anIndexPath.row];
    
    __block typeof(self.questListViewController) weakSelfQuestListViewController = self.questListViewController;
    
    void (^handler)(NSInteger) = ^void(NSInteger status)
    {
      BOOL success = (status == 0);
      if (success)
      {
        switch (state)
        {
          case kRPGQuestListTakeQuest:
          {
            [self.takeQuestsMutableArray removeObjectAtIndex:anIndexPath.row];
            break;
          }
          case kRPGQuestListInProgressQuest:
          {
            [self.inProgressQuestsMutableArray removeObjectAtIndex:anIndexPath.row];
            break;
          }
          case kRPGQuestListDoneQuest:
          {
            [self.doneQuestsMutableArray removeObjectAtIndex:anIndexPath.row];
            break;
          }
          default:
          {
            break;
          }
        }
        
        [aTableView reloadData];
      }
      else
      {
        NSString *message = @"Can't delete quest.";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete quest"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction *action)
        {
          [alert dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [weakSelfQuestListViewController presentViewController:alert animated:YES completion:nil];
      }
    };
    
    NSString *token = [[NSUserDefaults standardUserDefaults] sessionToken];
    RPGQuestRequest *request = [RPGQuestRequest questRequestWithToken:token questID:questID];
    [[RPGNetworkManager sharedNetworkManager] doQuestAction:kRPGQuestActionDeleteQuest
                                                    request:request
                                          completionHandler:handler];
  }
}

- (NSUInteger)getQuestIDByState:(RPGQuestListState)aState index:(NSUInteger)anIndex
{
  NSUInteger questID = 0;
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      questID = ((RPGQuest *)[self.takeQuestsMutableArray objectAtIndex:anIndex]).questID;
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      questID = ((RPGQuest *)[self.inProgressQuestsMutableArray objectAtIndex:anIndex]).questID;
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      questID = ((RPGQuest *)[self.doneQuestsMutableArray objectAtIndex:anIndex]).questID;
      break;
    }
    default:
    {
      break;
    }
  }
  return questID;
}

@end
