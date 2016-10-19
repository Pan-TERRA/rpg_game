//
//  RPGQuestListViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNibNames.h"
#import "RPGQuestListViewController.h"
#import "RPGQuestListTableViewCell.h"
#import "RPGQuestViewController.h"
#import "RPGQuestListState.h"

NSString * const kRPGQuestTitle = @"title";
NSString * const kRPGQuestDescription = @"description";
NSString * const kRPGQuestReward = @"reward";
NSString * const kRPGQuestState = @"state";

NSString * const kRPGQuestStringStateInProgress = @"In progress";
NSString * const kRPGQuestStringStateNotReviewed = @"Not reviewed";
NSString * const kRPGQuestStringStateReviewedFalse = @"Reviewed false";

@interface RPGQuestListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign, readwrite) IBOutlet UISegmentedControl *buttonControl;
@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, assign, readwrite) RPGQuestListState buttonLastState;
@property (nonatomic, retain, readwrite) NSMutableArray *takeQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *inProgressQuestsMutableArray;
@property (nonatomic, retain, readwrite) NSMutableArray *doneQuestsMutableArray;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RPGQuestListViewController

#pragma mark - Init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

#pragma mark - UIViewController Methods

- (void)viewDidLoad
{
  [super viewDidLoad];
  
    // test data
  NSDictionary *dict1 = @{@"title":@"Quest1 title",
                          @"description":@"Quest description. You can take this quest.",
                          @"reward":@"10", @"state":@"0"};
  NSDictionary *dict2 = @{@"title":@"Quest2 title",
                          @"description":@"Quest description. You have not done this quest yet.",
                          @"reward":@"20",
                          @"state":@"1"};
  NSDictionary *dict3 = @{@"title":@"Quest3 title",
                          @"description":@"Quest description. You have done this quest. But it has not been reviewed yet.",
                          @"reward":@"30",
                          @"state":@"2"};
  NSDictionary *dict4 = @{@"title":@"Quest4 title",
                          @"description":@"Quest description. You have done this quest. It has already been reviewed. But it has FALSE state.",
                          @"reward":@"40",
                          @"state":@"3"};
  NSDictionary *dict5 = @{@"title":@"Quest5 title",
                          @"description":@"Quest description. You have done this quest. It has already been reviewed. It has TRUE state.",
                          @"reward":@"50",
                          @"state":@"4"};
  
  [self.takeQuestsMutableArray addObject:dict1];
  [self.takeQuestsMutableArray addObject:dict1];
  [self.inProgressQuestsMutableArray addObject:dict2];
  [self.inProgressQuestsMutableArray addObject:dict3];
  [self.inProgressQuestsMutableArray addObject:dict4];
  [self.doneQuestsMutableArray addObject:dict5];
  [self.doneQuestsMutableArray addObject:dict5];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
  [self.buttonControl setSelectedSegmentIndex:self.buttonLastState];
  [self setTableHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self updateViewForState:self.buttonLastState];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Event handling

- (IBAction)buttonControlOnClick:(UISegmentedControl *)sender
{
  RPGQuestListState state = sender.selectedSegmentIndex;
  
  switch (state)
  {
    case kRPGQuestListTakeQuest:
      //upload from server self.takeQuestsMutableArray
      break;
    case kRPGQuestListInProgressQuest:
      //upload from server self.inProgressQuestsMutableArray
      break;
    case kRPGQuestListDoneQuest:
      //upload from server self.doneQuestsMutableArray
      break;
    case kRPGQuestListReviewQuest:
    {
        // test data
      //upload random quest from server to check
      NSDictionary *quest = @{@"title":@"Quest6 title",
                              @"description":@"Quest description. You have to review this quest.",
                              @"reward":@"60",
                              @"state":@"6"};
      
      [self showQuestViewWithQuest:quest];
      break;
    }
  }
  
  if (state != kRPGQuestListReviewQuest)
  {
    self.buttonLastState = state;
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:YES];
  }
  
}

- (IBAction)backButtonOnClicked:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSUInteger result = 0;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  RPGQuestListTableViewCell *cell = (RPGQuestListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kRPGQuestListTableViewCell];
  
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
      [cell setCellContent:[self.takeQuestsMutableArray objectAtIndex:indexPath.row]];
      break;
    case kRPGQuestListInProgressQuest:
      [cell setCellContent:[self.inProgressQuestsMutableArray objectAtIndex:indexPath.row]];
      break;
    case kRPGQuestListDoneQuest:
      [cell setCellContent:[self.doneQuestsMutableArray objectAtIndex:indexPath.row]];
      break;
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  RPGQuestListState state = self.buttonControl.selectedSegmentIndex;
  
  switch (state)
  {
    case kRPGQuestListTakeQuest:
      [self showQuestViewWithQuest:[self.takeQuestsMutableArray objectAtIndex:indexPath.row]];
      break;
    case kRPGQuestListInProgressQuest:
      [self showQuestViewWithQuest:[self.inProgressQuestsMutableArray objectAtIndex:indexPath.row]];
      break;
    case kRPGQuestListDoneQuest:
      [self showQuestViewWithQuest:[self.doneQuestsMutableArray objectAtIndex:indexPath.row]];
      break;
    default:
      break;
  }
}

#pragma mark - Quest View

- (void)showQuestViewWithQuest:(NSDictionary *)viewContent
{
  RPGQuestViewController *questViewController = [[[RPGQuestViewController alloc]
                                                  initWithNibName:kRPGQuestViewController
                                                  bundle:nil] autorelease];
  [self presentViewController:questViewController animated:YES completion:nil];
  [questViewController setViewContent:viewContent];
}

#pragma mark - Swipe Delete

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    switch (self.buttonControl.selectedSegmentIndex)
    {
      case kRPGQuestListTakeQuest:
        [self.takeQuestsMutableArray removeObjectAtIndex:indexPath.row];
        break;
      case kRPGQuestListInProgressQuest:
        [self.inProgressQuestsMutableArray removeObjectAtIndex:indexPath.row];
        break;
      case kRPGQuestListDoneQuest:
        [self.doneQuestsMutableArray removeObjectAtIndex:indexPath.row];
        break;
    }
    [tableView reloadData];
  }
}

- (void)updateViewForState:(RPGQuestListState)state
{
  void (^callback)(NSArray *) = ^(NSArray *questList)
  {
    switch (state)
    {
      case kRPGQuestListTakeQuest:
        self.takeQuestsMutableArray = [questList mutableCopy];
        break;
      case kRPGQuestListInProgressQuest:
        self.inProgressQuestsMutableArray = [questList mutableCopy];
        break;
      case kRPGQuestListDoneQuest:
        self.doneQuestsMutableArray = [questList mutableCopy];
        break;
      default:
        break;
    }
    [self setTableHidden:NO];
    [self.tableView reloadData];
  };
  
  switch (state)
  {
    case kRPGQuestListTakeQuest:
      //upload from server self.takeQuestsMutableArray
      //pass callback to NetworkManager method
      break;
    case kRPGQuestListInProgressQuest:
      //upload from server self.inProgressQuestsMutableArray
      //pass callback to NetworkManager method
      break;
    case kRPGQuestListDoneQuest:
      //upload from server self.doneQuestsMutableArray
      //pass callback to NetworkManager method
      break;
    case kRPGQuestListReviewQuest:
    {
      // test data
      //upload random quest from server to check
      NSDictionary *quest = @{@"title":@"Quest6 title",
                              @"description":@"Quest description. You have to review this quest.",
                              @"reward":@"60",
                              @"state":@"6"};
      
      [self showQuestViewWithQuest:quest];
      break;
    }
  }
  if (state != kRPGQuestListReviewQuest)
  {
    self.buttonLastState = state;
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:YES];
  }
}

- (void)setTableHidden:(BOOL)flag
{
  [self.tableView setHidden:flag];
  [self.activityIndicator setHidden:!flag];
  if (flag)
  {
    [self.activityIndicator startAnimating];
  }
  else
  {
    [self.activityIndicator stopAnimating];
  }
}

@end