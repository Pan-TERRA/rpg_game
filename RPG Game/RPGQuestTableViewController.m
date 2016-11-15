//
//  RPGQuestTableController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/31/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestTableViewController.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // Views
#import "RPGQuestListViewController.h"
#import "RPGQuestListTableViewCell.h"
  // Entities
#import "RPGQuest.h"
#import "RPGQuestRequest.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGQuestListState.h"

#import "RPGAlert.h"

CGFloat const kRPGQuestListViewControllerRefreshIndicatorOffset = -30;

@interface RPGQuestTableViewController ()

@property (nonatomic, assign, readwrite, getter=canUpdateWhenScrollTable) BOOL updateWhenScrollTable;
@property (assign, nonatomic, readwrite, getter=isDragging) BOOL dragging;

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
    _dragging = NO;
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
      
      [self.questListViewController updateViewForState:self.questListState shouldReload:YES];
    }
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  self.dragging = YES;
  self.updateWhenScrollTable = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate
{
  self.dragging = NO;
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
  [self.questListViewController setViewForNoQuests:(result == 0)];
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
    cell = nib.firstObject;
  }
  
  cell.backgroundColor = [UIColor clearColor];
  cell.backgroundView = [[UIView new] autorelease];
  cell.selectedBackgroundView = [[UIView new] autorelease];
  cell.tableViewController = self;
  
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

#pragma mark - DeleteQuest

- (void)deleteQuestWithID:(NSUInteger)aQuestID
{
    RPGQuestListState state = self.questListState;
    
    void (^handler)(NSInteger) = ^void(NSInteger status)
    {
      BOOL success = (status == 0);
      if (success)
      {
        [self removeQuestWithID:aQuestID forState:state];
      }
      else
      {
        [RPGAlert showAlertWithTitle:@"Delete quest" message:@"Can't delete quest." completion:nil];
      }
    };
    
    NSString *token = [[NSUserDefaults standardUserDefaults] sessionToken];
    RPGQuestRequest *request = [RPGQuestRequest questRequestWithToken:token questID:aQuestID];
    [[RPGNetworkManager sharedNetworkManager] doQuestAction:kRPGQuestActionDeleteQuest
                                                    request:request
                                          completionHandler:handler];
}

- (void)removeQuestWithID:(NSUInteger)aQuestID forState:(RPGQuestListState)aState
{
  NSMutableArray *questArray = nil;
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      questArray = self.takeQuestsMutableArray;
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      questArray = self.inProgressQuestsMutableArray;
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      questArray = self.doneQuestsMutableArray;
      break;
    }
    default:
    {
      break;
    }
  }
  if (questArray != nil)
  {
    for(RPGQuest *quest in questArray)
    {
      if (quest.questID == aQuestID)
      {
        [questArray removeObject:quest];
        [self.tableView reloadData];
        break;
      }
    }
  }
}

@end
