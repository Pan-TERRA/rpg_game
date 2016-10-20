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
  // Network, entities
#import "RPGNetworkManager+Quests.h"
#import "RPGQuest+Serialization.h"
#import "RPGQuestReward+Serialization.h"
  // Constants
#import "RPGQuestListState.h"
#import "RPGNibNames.h"

NSString * const kRPGQuestStringStateInProgress = @"In progress";
NSString * const kRPGQuestStringStateNotReviewed = @"Not reviewed";
NSString * const kRPGQuestStringStateReviewedFalse = @"Reviewed false";

typedef void (^fetchQuestsCompletionHandler)(NSInteger, NSArray *);

@interface RPGQuestListViewController () <UITableViewDelegate, UITableViewDataSource>

// !!!: rename
@property (nonatomic, assign, readwrite) IBOutlet UISegmentedControl *buttonControl;

@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign, readwrite) RPGQuestListState buttonLastState;
@property (nonatomic, retain, readwrite) NSMutableArray *takeQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *inProgressQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *doneQuestsMutableArray;

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
  [self.buttonControl setSelectedSegmentIndex:self.buttonLastState];
  [self setViewToNormalState];
}

- (void)viewDidAppear:(BOOL)anAnimated
{
  [super viewDidAppear:anAnimated];
  [self updateViewForState:self.buttonLastState];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
  NSUInteger result = 0;
    // ???: create new property viewState?
  switch (self.buttonControl.selectedSegmentIndex)
  {
    case kRPGQuestListTakeQuest:
      result = [self.takeQuestsMutableArray count];
      break;
    case kRPGQuestListInProgressQuest:
      result = [self.inProgressQuestsMutableArray count];
      break;
    case kRPGQuestListDoneQuest:
      result = [self.doneQuestsMutableArray count];
      break;
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
    cell = [nib objectAtIndex:0];
  }
  
  switch (self.buttonControl.selectedSegmentIndex)
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
  switch (self.buttonControl.selectedSegmentIndex)
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
  }
}

#pragma mark - View Update


/**
 *  Provides data display. Invokes at viewDidAppeer, buttonControlOnClick.
 *
 *  @param aState A view state. Depends from self.buttonControl.selectedSegmentIndex.
 */
- (void)updateViewForState:(RPGQuestListState)aState
{
  [self setViewToWaitingForServerResponseState];
  
  fetchQuestsCompletionHandler handler = ^void(NSInteger status, NSArray *questList)
  {
    [self setViewToNormalState];
    
    BOOL succes = (status == 0);
    if (succes)
    {
      [self separateQuestsData:questList byState:aState];
    }
  };
  
  [self fetchQuestsDataByState:aState completionHandler:handler];
}

#pragma mark - View State

- (void)setViewToWaitingForServerResponseState
{
  [self.tableView setHidden:YES];
  [self.activityIndicator setHidden:NO];
  [self.activityIndicator startAnimating];
}

- (void)setViewToNormalState
{
  [self.tableView setHidden:NO];
  [self.activityIndicator setHidden:YES];
  [self.activityIndicator stopAnimating];
}

#pragma mark - Quest Data Handling

/**
 *  Separate array of RPGQuest items to specific model arrays
 *
 *  @param aData  An array from RPGQuestListResponse
 *  @param aState A view state
 */
- (void)separateQuestsData:(NSArray *)aData byState:(RPGQuestListState)aState
{
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
        // ???: mutable copy? already mutable, check this
      self.takeQuestsMutableArray = [aData mutableCopy];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      self.inProgressQuestsMutableArray = [aData mutableCopy];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      self.doneQuestsMutableArray = [aData mutableCopy];
      break;
    }
    default:
    {
      break;
    }
  }
  
  [self.tableView reloadData];
}

- (void)fetchQuestsDataByState:(RPGQuestListState)aState completionHandler:(void (^)(NSInteger status, NSArray *quests))aCompletionHandler
{
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    case kRPGQuestListInProgressQuest:
    case kRPGQuestListDoneQuest:
    {
      [[RPGNetworkManager sharedNetworkManager] fetchQuestsByState:aState
                                                 completionHandler:aCompletionHandler];
      break;
    }
      
    case kRPGQuestListReviewQuest:
    {
        // test data
      RPGQuest *testQuest = [RPGQuest questWithID:34343
                                             name:@"Quest6 title"
                                      description:@"Quest description. You have to review this quest."
                                            state:6
                                           reward:[RPGQuestReward questRewardWithGold:20 crystals:29 skillID:22]];
      
      [self showQuestViewWithQuest:testQuest];
      break;
    }
  }
  
  if (aState != kRPGQuestListReviewQuest)
  {
    self.buttonLastState = aState;
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:YES];
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
    //send to server that quest should be deleted
  if (anEditingStyle == UITableViewCellEditingStyleDelete)
  {
    switch (self.buttonControl.selectedSegmentIndex)
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
    }
    [aTableView reloadData];
  }
}

#pragma mark - IBActions

- (IBAction)buttonControlOnClick:(UISegmentedControl *)aSender
{
  RPGQuestListState state = aSender.selectedSegmentIndex;
  
  [self updateViewForState:state];
}

- (IBAction)backButtonOnClicked:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
