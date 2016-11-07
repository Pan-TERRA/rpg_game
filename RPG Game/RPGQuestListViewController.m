   //
  //  RPGQuestListViewController.m
  //  RPG Game
  //
  //  Created by Максим Шульга on 10/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGQuestListViewController.h"
  // Views
#import "RPGQuestViewController.h"
#import "RPGLoginViewController.h"
#import "RPGQuestTableViewController.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGAlert.h"

NSString * const kRPGQuestStringStateInProgress = @"In progress";
NSString * const kRPGQuestStringStateNotReviewed = @"Not reviewed";
NSString * const kRPGQuestStringStateReviewedFalse = @"Reviewed false";

typedef void (^fetchQuestsCompletionHandler)(NSInteger, NSArray *);

@interface RPGQuestListViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;

@property (nonatomic, assign, readwrite) IBOutlet UIButton *takeQuestListButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *inProgressQuestListButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *doneQuestListButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *reviewQuestButton;
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
  RPGQuestListState state = self.tableViewController.questListState;
  [self setActiveButtonForState:state];
  [self updateViewForState:state shouldReload:YES];
  [self setViewToNormalState];
}

- (void)viewDidAppear:(BOOL)anAnimated
{
  [super viewDidAppear:anAnimated];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - View Update

  //Invokes at viewWillAppear, scrollViewDidScroll, viewStateButtonControlOnClick.
- (void)updateViewForState:(RPGQuestListState)aState shouldReload:(BOOL)aShouldReloadFlag
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
        if (aShouldReloadFlag)
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
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:loginViewController completion:nil];
        break;
      }
      default:
      {
        NSString *message = @"Can't update quest list.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:weakSelf completion:nil];
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
    [self updateViewForState:self.tableViewController.questListState shouldReload:YES];
  }
}

#pragma mark - View State

- (void)setViewToWaitingForServerResponseState
{
  [self.activityIndicator setHidden:NO];
  [self.activityIndicator startAnimating];
}

- (void)setViewToNormalState
{
  [self.activityIndicator setHidden:YES];
  [self.activityIndicator stopAnimating];
}

#pragma mark - Quest Data Handling

/**
 *  Separates array of RPGQuest items to specific model arrays
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
      if ([aData count])
      {
        [self showQuestViewWithQuest:[aData firstObject]];
      }
      else
      {
        NSString *message = @"No quests for review.";
        [RPGAlert showAlertViewControllerWithTitle:@"Error" message:message viewController:self completion:nil];
        [self setActiveButtonForState:self.tableViewController.questListState];
      }
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

- (IBAction)viewStateButtonOnClick:(UIButton *)aSender
{
  RPGQuestListState state = aSender.tag;
  [self setActiveButtonForState:state];
  
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
      [self updateViewForState:state shouldReload:YES];
      break;
    }
  }
}

- (IBAction)backButtonOnClicked:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Set Button Background

- (void)setActiveButtonForState:(RPGQuestListState)aState
{
  UIButton *takeQuestListButton = self.takeQuestListButton;
  UIButton *inProgressQuestListButton = self.inProgressQuestListButton;
  UIButton *doneQuestListButton = self.doneQuestListButton;
  UIButton *reviewQuestButton = self.reviewQuestButton;
  
  [self toggleButtonBackground:takeQuestListButton active:NO];
  [self toggleButtonBackground:inProgressQuestListButton active:NO];
  [self toggleButtonBackground:doneQuestListButton active:NO];
  [self toggleButtonBackground:reviewQuestButton active:NO];

  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      [self toggleButtonBackground:takeQuestListButton active:YES];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
     [self toggleButtonBackground:inProgressQuestListButton active:YES];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [self toggleButtonBackground:doneQuestListButton active:YES];
      break;
    }
    case kRPGQuestListReviewQuest:
    {
      [self toggleButtonBackground:reviewQuestButton active:YES];
      break;
    }
  }
}

- (void)toggleButtonBackground:(UIButton *)aButton active:(BOOL)anActiveFlag
{
  UIImage *activeButtonImage = [UIImage imageNamed:@"main_button_active"];
  UIImage *inactiveButtonImage = [UIImage imageNamed:@"main_button_inactive"];
 
  [aButton setBackgroundImage:(anActiveFlag ? activeButtonImage : inactiveButtonImage)
                     forState:UIControlStateNormal];
  [aButton setBackgroundImage:(!anActiveFlag ? activeButtonImage : inactiveButtonImage)
                     forState:UIControlStateSelected | UIControlStateHighlighted];
 
}

@end
