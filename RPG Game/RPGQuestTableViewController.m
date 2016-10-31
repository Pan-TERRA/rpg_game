//
//  RPGQuestTableController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/31/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestTableController.h"
#import <UIKit/UIKit.h>
#import "RPGQuestListViewController.h"
#import "RPGQuestListTableViewCell.h"
#import "RPGQuestListState.h"
#import "RPGNibNames.h"

CGFloat const kRPGQuestListViewControllerRefreshIndicatorOffset = -30;

@interface RPGQuestTableController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign, readwrite) UITableView *tableView;
@property (nonatomic, assign, readwrite) RPGQuestListState questListState;
@property (nonatomic, retain, readwrite) NSMutableArray *takeQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *inProgressQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *doneQuestsMutableArray;

@property(nonatomic, assign, readwrite, getter=isInProgressQuestsVisited) BOOL inProgressQuestsVisited;
@property(nonatomic, assign, readwrite, getter=isDoneQuestsVisited) BOOL doneQuestsVisited;
@property(nonatomic, assign, readwrite, getter=canUpdateWhenScrollTable) BOOL updateWhenScrollTable;

@property(nonatomic, retain, readwrite) RPGQuestListViewController *parent;

@end

@implementation RPGQuestTableController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGQuestListViewController bundle:nil];
  
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
      
      [self.parent updateViewForState:self.questListState willReload:NO];
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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
  [self.tableView reloadData];
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
  RPGQuestListTableViewCell *cell = (RPGQuestListTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:kRPGQuestListTableViewCell];
  
  if (cell == nil)
  {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kRPGQuestListTableViewCell
                                                 owner:self
                                               options:nil];
    cell = [nib firstObject];
  }
  
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
  return 150;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)anIndexPath
{
  switch (self.questListState)
  {
    case kRPGQuestListTakeQuest:
    {
      [self.parent showQuestViewWithQuest:[self.takeQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      [self.parent showQuestViewWithQuest:[self.inProgressQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [self.parent showQuestViewWithQuest:[self.doneQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    default:
    {
      break;
    }
  }
}

@end
