   //
  //  RPGQuestListViewController.m
  //  RPG Game
  //
  //  Created by Максим Шульга on 10/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

  // Views
#import "RPGQuestListViewController.h"
#import "RPGQuestListTableViewCell.h"
#import "RPGQuestViewController.h"
#import "RPGLoginViewController.h"
  // Network, entities
#import "RPGNetworkManager+Quests.h"
#import "RPGQuest+Serialization.h"
#import "RPGQuestReward+Serialization.h"
#import "RPGQuestRequest.h"
  // Constants
#import "RPGQuestListState.h"
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"

#import "NSUserDefaults+RPGSessionInfo.h"

CGFloat const kRPGQuestListViewControllerRefreshIndicatorOffset = -30;

NSString * const kRPGQuestStringStateInProgress = @"In progress";
NSString * const kRPGQuestStringStateNotReviewed = @"Not reviewed";
NSString * const kRPGQuestStringStateReviewedFalse = @"Reviewed false";

typedef void (^fetchQuestsCompletionHandler)(NSInteger, NSArray *);

@interface RPGQuestListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign, readwrite) IBOutlet UISegmentedControl *viewStateButtonControl;
@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign, readwrite) RPGQuestListState questListState;
@property (nonatomic, retain, readwrite) NSMutableArray *takeQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *inProgressQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *doneQuestsMutableArray;

@property(nonatomic, assign, readwrite, getter=isInProgressQuestsVisited) BOOL inProgressQuestsVisited;
@property(nonatomic, assign, readwrite, getter=isDoneQuestsVisited) BOOL doneQuestsVisited;
@property(nonatomic, assign, readwrite, getter=canUpdateWhenScrollTable) BOOL updateWhenScrollTable;

@end

@implementation RPGQuestListViewController

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

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
  [self.viewStateButtonControl setSelectedSegmentIndex:self.questListState];
  [self setViewToNormalState];
}

- (void)viewDidAppear:(BOOL)anAnimated
{
  [super viewDidAppear:anAnimated];
  [self updateViewForState:self.questListState willReload:YES];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
  {
    mask = UIInterfaceOrientationMaskLandscape;
  }
  return mask;
}

#pragma mark - UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
  if (aScrollView.contentOffset.y < kRPGQuestListViewControllerRefreshIndicatorOffset)
  {
    if (self.canUpdateWhenScrollTable)
    {
      self.updateWhenScrollTable = NO;
  
      [self updateViewForState:self.questListState willReload:NO];
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
      [self showQuestViewWithQuest:[self.takeQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      [self showQuestViewWithQuest:[self.inProgressQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [self showQuestViewWithQuest:[self.doneQuestsMutableArray objectAtIndex:anIndexPath.row]];
      break;
    }
    default:
    {
      break;
    }
  }
}

#pragma mark - View Update

/**
 *  Provides data display. Invokes at viewDidAppear, scrollViewDidScroll, viewStateButtonControlOnClick.
 *
 *  @param aState A view state. Depends from self.buttonControl.selectedSegmentIndex.
 *  @param aWillReloadFlag
 */
- (void)updateViewForState:(RPGQuestListState)aState willReload:(BOOL)aWillReloadFlag
{
  [self setViewToWaitingForServerResponseState];
  
  __block typeof(self) weakSelf = self;
  
  fetchQuestsCompletionHandler handler = ^void(NSInteger statusCode, NSArray *questList)
  {
    [weakSelf setViewToNormalState];
    
    switch (statusCode)
    {
      case kRPGStatusCodeOk:
      {
        [weakSelf processQuestsData:questList byState:aState];
        if (aWillReloadFlag)
        {
          [weakSelf.tableView reloadData];
        }
        break;
      }
      case kRPGStatusCodeWrongToken:
      {
        RPGLoginViewController *loginViewController = [[[RPGLoginViewController alloc] init] autorelease];
        [self presentViewController:loginViewController
                           animated:YES
                         completion:nil];
        break;
      }
      default:
      {
        break;
      }
    }
  };
  
  [[RPGNetworkManager sharedNetworkManager] fetchQuestsByState:aState
                                             completionHandler:handler];
}

/**
 *  Define if quest array should be uploaded from server.
 *
 *  @param aFlag A boolean value that defines action
 */
- (void)shouldUpdateView:(BOOL)aFlag
{
  if (aFlag)
  {
    [self.tableView reloadData];
  }
  else
  {
    [self updateViewForState:self.questListState willReload:YES];
  }
}

#pragma mark - View State

- (void)setViewToWaitingForServerResponseState
{
//  [self.tableView setHidden:YES];
  [self.activityIndicator setHidden:NO];
  [self.activityIndicator startAnimating];
}

- (void)setViewToNormalState
{
//  [self.tableView setHidden:NO];
  [self.activityIndicator setHidden:YES];
  [self.activityIndicator stopAnimating];
}

#pragma mark - Quest Data Handling

/**
 *  Separate array of RPGQuest items to specific model arrays
 *  or show with quest for review.
 *
 *  @param aData  An array from RPGQuestListResponse
 *  @param aState A view state
 */
- (void)processQuestsData:(NSArray *)aData byState:(RPGQuestListState)aState
{
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      // ???: Tramper question
      self.takeQuestsMutableArray = (NSMutableArray *)aData;
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      self.inProgressQuestsMutableArray = (NSMutableArray *)aData;
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      self.doneQuestsMutableArray = (NSMutableArray *)aData;
      break;
    }
    case kRPGQuestListReviewQuest:
    {
      [self showQuestViewWithQuest:[aData firstObject]];
      break;
    }
  }
}

#pragma mark - QuestView Display

- (void)showQuestViewWithQuest:(RPGQuest *)aQuest
{
  RPGQuestViewController *questViewController = [[RPGQuestViewController alloc] init];
  [self presentViewController:questViewController animated:YES completion:nil];
  [questViewController setViewContent:aQuest];
  [questViewController release];
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
        
        [self presentViewController:alert animated:YES completion:nil];
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

#pragma mark - IBActions

- (IBAction)viewStateButtonControlOnClick:(UISegmentedControl *)aSender
{
  RPGQuestListState state = aSender.selectedSegmentIndex;
  
  if (state != kRPGQuestListReviewQuest)
  {
    self.questListState = state;
  }
  
  switch (state)
  {
    case kRPGQuestListTakeQuest:
    {
      [self.tableView reloadData];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      [self shouldUpdateView:self.isInProgressQuestsVisited];
      self.inProgressQuestsVisited = YES;
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [self shouldUpdateView:self.isDoneQuestsVisited];
      self.doneQuestsVisited = YES;
      break;
    }
    case kRPGQuestListReviewQuest:
    {
      [self updateViewForState:state willReload:YES];
    }
    default:
    {
      break;
    }
  }
}

- (IBAction)backButtonOnClicked:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
