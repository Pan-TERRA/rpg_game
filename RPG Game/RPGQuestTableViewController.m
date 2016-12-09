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
#import "RPGStatusCodes.h"
#import "RPGQuestListState.h"

#import "RPGAlertController+RPGErrorHandling.h"

static CGFloat const kRPGQuestListViewControllerRefreshIndicatorOffset = -30.0;
static NSUInteger const kRPGQuestListViewControllerTableViewCellHeight = 200;

@interface RPGQuestTableViewController () <UITableViewDelegate, UITableViewDataSource, RPGTableViewCellDelegate>

@property (nonatomic, retain, readwrite) NSMutableArray<RPGQuest *> *takeQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGQuest *> *inProgressQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGQuest *> *doneQuestsMutableArray;
@property (nonatomic, assign, readwrite) UITableView *tableView;
@property (nonatomic, assign, readwrite, getter=canUpdateWhenScrollTable) BOOL updateWhenScrollTable;
@property (nonatomic, assign, readwrite, getter=isDragging) BOOL dragging;

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

- (instancetype)initWithTableView:(UITableView *)aTableView
{
  self = [self init];
  
  if (self != nil)
  {
    _tableView = aTableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
      
      [self.delegate updateViewForState:self.questListState
                           shouldReload:YES];
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
  
  [self.delegate setViewToNoQuestsState:(result == 0)];
  
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
  cell.delegate = self;
  
  RPGQuest *cellContent = nil;
  NSInteger index = anIndexPath.row;
  
  switch (self.questListState)
  {
    case kRPGQuestListTakeQuest:
    {
      cellContent = self.takeQuestsMutableArray[index];
      break;
    }
      
    case kRPGQuestListInProgressQuest:
    {
      cellContent = self.inProgressQuestsMutableArray[index];
      break;
    }
      
    case kRPGQuestListDoneQuest:
    {
      cellContent = self.doneQuestsMutableArray[index];
      break;
    }
      
    default:
    {
      break;
    }
  }
  
  if (cellContent != nil)
  {
    [cell setCellContent:cellContent];
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  return kRPGQuestListViewControllerTableViewCellHeight;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGQuest *quest = nil;
  NSInteger index = anIndexPath.row;
  
  switch (self.questListState)
  {
    case kRPGQuestListTakeQuest:
    {
      quest = self.takeQuestsMutableArray[index];
      break;
    }
      
    case kRPGQuestListInProgressQuest:
    {
      quest = self.inProgressQuestsMutableArray[index];
      break;
    }
      
    case kRPGQuestListDoneQuest:
    {
      quest = self.doneQuestsMutableArray[index];
      break;
    }
      
    default:
    {
      break;
    }
  }
  
  if (quest != nil)
  {
    [self.delegate showQuestViewWithQuest:quest];
  }
}

#pragma mark - DeleteQuest

- (void)removeQuestWithID:(NSInteger)aQuestID
                 forState:(RPGQuestListState)aState
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

#pragma mark - Set Quests

- (void)setQuests:(NSArray<RPGQuest *> *)aQuests
forQuestListState:(RPGQuestListState)aState
{
  NSMutableArray *mutableArrayToSet = [[aQuests mutableCopy] autorelease];
  
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      self.takeQuestsMutableArray = mutableArrayToSet;
      break;
    }
      
    case kRPGQuestListInProgressQuest:
    {
      self.inProgressQuestsMutableArray = mutableArrayToSet;
      break;
    }
      
    case kRPGQuestListDoneQuest:
    {
      self.doneQuestsMutableArray = mutableArrayToSet;
      break;
    }
      
    default:
    {
      break;
    }
  }
}

#pragma mark - RPGTableViewCellDelegate

- (void)deleteQuestWithID:(NSInteger)aQuestID
{
  RPGQuestListState state = self.questListState;
  
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithQuestID:aQuestID];
  [[RPGNetworkManager sharedNetworkManager] doQuestAction:kRPGQuestActionDeleteQuest
                                                  request:request
                                        completionHandler:^void(RPGStatusCode aNetworkStatusCode)
   {
     BOOL success = (aNetworkStatusCode == kRPGStatusCodeOK);
     
     if (success)
     {
       [self removeQuestWithID:aQuestID
                      forState:state];
     }
     else
     {
       [RPGAlertController showAlertWithTitle:@"Delete quest"
                                      message:@"Can't delete quest."
                                  actionTitle:nil
                                   completion:nil];
     }
   }];
}

- (void)getRewardForQuestWithID:(NSInteger)aQuestID
{
  __block id weakDelegate = self.delegate;
  RPGQuestListState state = self.questListState;
  RPGQuestRequest *request = [RPGQuestRequest questRequestWithQuestID:aQuestID];
  
  [[RPGNetworkManager sharedNetworkManager] getQuestRewardWithRequest:request
                                                    completionHandler:^void(RPGStatusCode aNetworkStatusCode)
   {
     switch (aNetworkStatusCode)
     {
       case kRPGStatusCodeOK:
       {
         [weakDelegate updateViewForState:state
                             shouldReload:YES];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [RPGAlertController showErrorWithStatusCode:kRPGStatusCodeWrongToken
                                   completionHandler:^(void)
          {
            dispatch_async(dispatch_get_main_queue(), ^
            {
              UIViewController *viewController = [weakDelegate getViewController].presentingViewController.presentingViewController;
              [viewController dismissViewControllerAnimated:YES
                                                 completion:nil];
            });
          }];
         break;
       }
         
       default:
       {
         NSString *message = @"Can't get reward.";
         [RPGAlertController showAlertWithTitle:nil
                                        message:message
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
     }
   }];
}

@end
