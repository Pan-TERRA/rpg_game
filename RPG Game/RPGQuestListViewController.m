   //
  //  RPGQuestListViewController.m
  //  RPG Game
  //
  //  Created by Максим Шульга on 10/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

  // Views
#import "RPGQuestListViewController.h"
#import "RPGQuestViewController.h"
#import "RPGLoginViewController.h"
  // Network, entities
#import "RPGNetworkManager+Quests.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"

#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGQuestTableViewController.h"

NSString * const kRPGQuestStringStateInProgress = @"In progress";
NSString * const kRPGQuestStringStateNotReviewed = @"Not reviewed";
NSString * const kRPGQuestStringStateReviewedFalse = @"Reviewed false";

typedef void (^fetchQuestsCompletionHandler)(NSInteger, NSArray *);

@interface RPGQuestListViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UISegmentedControl *viewStateButtonControl;
@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic, assign, readwrite, getter=isInProgressQuestsVisited) BOOL inProgressQuestsVisited;
@property(nonatomic, assign, readwrite, getter=isDoneQuestsVisited) BOOL doneQuestsVisited;

@property(nonatomic, retain, readwrite) RPGQuestTableViewController *tableViewController;

@end

@implementation RPGQuestListViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGQuestListViewControllerNIBName bundle:nil];
  if (self != nil)
  {
    _tableViewController = [[RPGQuestTableViewController alloc] init];
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_tableViewController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableViewController.questListViewController = self;
  self.tableView.dataSource = self.tableViewController;
  self.tableView.delegate = self.tableViewController;
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
  [self.viewStateButtonControl setSelectedSegmentIndex:self.tableViewController.questListState];
  [self setViewToNormalState];
}

- (void)viewDidAppear:(BOOL)anAnimated
{
  [super viewDidAppear:anAnimated];
  [self updateViewForState:self.tableViewController.questListState willReload:YES];
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
        UIViewController *loginViewController = self.presentingViewController.presentingViewController;
        [loginViewController dismissViewControllerAnimated:YES completion:nil];
        NSString *message = @"Can't update quest list.\nWrong token error.\nTry to log in again.";
        [weakSelf showAlertViewControllerWithMessage:message viewController:loginViewController];
        break;
      }
      default:
      {
        NSString *message = @"Can't update quest list.";
        [weakSelf showAlertViewControllerWithMessage:message viewController:weakSelf];
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
    [self updateViewForState:self.tableViewController.questListState willReload:YES];
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
      self.tableViewController.takeQuestsMutableArray = (NSMutableArray *)aData;
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      self.tableViewController.inProgressQuestsMutableArray = (NSMutableArray *)aData;
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      self.tableViewController.doneQuestsMutableArray = (NSMutableArray *)aData;
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

#pragma mark - IBActions

- (IBAction)viewStateButtonControlOnClick:(UISegmentedControl *)aSender
{
  RPGQuestListState state = aSender.selectedSegmentIndex;
  
  if (state != kRPGQuestListReviewQuest)
  {
    self.tableViewController.questListState = state;
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

#pragma mark - Show Alert

- (void)showAlertViewControllerWithMessage:(NSString *)message viewController:(UIViewController *)viewController
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                            style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction *action)
  {
    [alert dismissViewControllerAnimated:YES completion:nil];
  }]];
  
  [viewController presentViewController:alert animated:YES completion:nil];
}

@end
