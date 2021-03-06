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
#import "RPGQuestTableViewCell.h"
  // API
#import "RPGNetworkManager+Quests.h"
  // Entities
#import "RPGQuestListResponse.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "UIViewController+RPGWrongTokenHandling.h"
#import "RPGAlertController.h"

@interface RPGQuestListViewController () <RPGQuestTableViewControllerDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *takeQuestListButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *inProgressQuestListButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *doneQuestListButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *reviewQuestButton;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *messageLabel;

@property (nonatomic, retain, readwrite) RPGQuestTableViewController *tableViewController;

@property (nonatomic, assign, readwrite) RPGQuestType questType;

@end

@implementation RPGQuestListViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGQuestListViewControllerNIBName
                         bundle:nil];
  
  if (self != nil)
  {
    _tableViewController = [[RPGQuestTableViewController alloc] init];
    _sendRequest = YES;
    _questType = kRPGQuestTypeSingle;
  }
  
  return self;
}

- (instancetype)initWithType:(RPGQuestType)aType
{
  self = [self init];
  
  if (self != nil)
  {
    _questType = aType;
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
  
  self.tableViewController = [[[RPGQuestTableViewController alloc] initWithTableView:self.tableView] autorelease];
  self.tableViewController.delegate = self;
  self.tableViewController.questListState = kRPGQuestListTakeQuest;
  self.tableViewController.questType = self.questType;
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

- (UIViewController *)getViewController
{
  return self;
}

#pragma mark - View Update

/**
 *  Update the quest list table view.
 *  Invokes at viewWillAppear, scrollViewDidScroll, viewStateButtonControlOnClick.
 *
 *  @param aState            A qust list state.
 *  @param aShouldReloadFlag A flag that indicates whether to perform
 *         reloadData method on table or not.
 */
- (void)updateViewForState:(RPGQuestListState)aState
              shouldReload:(BOOL)aShouldReloadFlag
{
  if (self.canSendRequest)
  {
    self.sendRequest = NO;
    [self setViewToWaitingForServerResponseState];
    
    __block typeof(self) weakSelf = self;
    
    [[RPGNetworkManager sharedNetworkManager] fetchQuestsByType:self.questType
                                                          state:aState
                                              completionHandler:^void(RPGStatusCode aNetworkStatusCode,
                                                                      RPGQuestListResponse *aResponse)
    {
      self.sendRequest = YES;
      [weakSelf setViewToNormalState];
      
      switch (aNetworkStatusCode)
      {
        case kRPGStatusCodeOK:
        {
          [weakSelf processQuestsData:aResponse.quests
                              byState:aState];
          
          if (aShouldReloadFlag)
          {
            [weakSelf.tableView reloadData];
          }
          else if (self.tableView.isDragging)
          {
             [weakSelf.tableView reloadData];
          }
          break;
        }
          
        case kRPGStatusCodeWrongToken:
        {
          [self handleWrongTokenError];
          
          break;
        }
          
        default:
        {
          NSString *message = @"Can't update quest list.";
          [RPGAlertController showAlertWithTitle:nil
                                         message:message
                                     actionTitle:nil
                                      completion:nil];
          break;
        }
      }
    }];
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

- (void)setViewToNoQuestsState:(BOOL)aFlag
{
  self.messageLabel.hidden = !aFlag;
}

#pragma mark - Quest Data Handling

/**
 *  Separates array of RPGQuest items to specific model arrays
 *  or show with quest for review.
 *
 *  @param aData  An array from RPGQuestListResponse
 *  @param aState A view state
 */
- (void)processQuestsData:(NSArray *)aData
                  byState:(RPGQuestListState)aState
{
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      [self.tableViewController setQuests:aData
                        forQuestListState:kRPGQuestListTakeQuest];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      [self.tableViewController setQuests:aData
                        forQuestListState:kRPGQuestListInProgressQuest];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [self.tableViewController setQuests:aData
                        forQuestListState:kRPGQuestListDoneQuest];
      break;
    }
    case kRPGQuestListReviewQuest:
    {
      if (aData.count != 0)
      {
        [self showQuestViewWithQuest:aData.firstObject];
      }
      else
      {
        NSString *message = @"No quests for review.";
        [RPGAlertController showAlertWithTitle:@"Wow"
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        
        [self setActiveButtonForState:self.tableViewController.questListState];
      }
      break;
    }
  }
}

#pragma mark - QuestView Display

- (void)showQuestViewWithQuest:(RPGQuest *)aQuest
{
  RPGQuestViewController *questViewController = [[[RPGQuestViewController alloc] init] autorelease];
  
  [self presentViewController:questViewController
                     animated:YES
                   completion:nil];
  [questViewController setViewContent:aQuest];
}

#pragma mark - IBActions

- (IBAction)viewStateButtonOnClick:(UIButton *)aSender
{
  RPGQuestListState state = aSender.tag;
  [self setActiveButtonForState:state];
  
  if (state != kRPGQuestListReviewQuest)
  {
    self.tableViewController.questListState = state;
    [self updateViewForState:self.tableViewController.questListState
                shouldReload:YES];
  }
  else
  {
    [self updateViewForState:state
                shouldReload:NO];
  }
}

- (IBAction)backButtonOnClicked:(UIButton *)aSender
{
  [self dismissViewControllerAnimated:YES
                           completion:nil];
}

#pragma mark - Set Button Background

- (void)setActiveButtonForState:(RPGQuestListState)aState
{
  UIButton *takeQuestListButton = self.takeQuestListButton;
  UIButton *inProgressQuestListButton = self.inProgressQuestListButton;
  UIButton *doneQuestListButton = self.doneQuestListButton;
  UIButton *reviewQuestButton = self.reviewQuestButton;
  
  [self toggleButtonBackground:takeQuestListButton
                        active:NO];
  [self toggleButtonBackground:inProgressQuestListButton
                        active:NO];
  [self toggleButtonBackground:doneQuestListButton
                        active:NO];
  [self toggleButtonBackground:reviewQuestButton
                        active:NO];

  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      [self toggleButtonBackground:takeQuestListButton
                            active:YES];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      [self toggleButtonBackground:inProgressQuestListButton
                            active:YES];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      [self toggleButtonBackground:doneQuestListButton
                            active:YES];
      break;
    }
    case kRPGQuestListReviewQuest:
    {
      [self toggleButtonBackground:reviewQuestButton
                            active:YES];
      break;
    }
  }
}

- (void)toggleButtonBackground:(UIButton *)aButton
                        active:(BOOL)anActiveFlag
{
  UIImage *activeButtonImage = [UIImage imageNamed:@"main_button_active"];
  UIImage *inactiveButtonImage = [UIImage imageNamed:@"main_button_inactive"];
 
  [aButton setBackgroundImage:(anActiveFlag ? activeButtonImage : inactiveButtonImage)
                     forState:UIControlStateNormal];
  [aButton setBackgroundImage:(!anActiveFlag ? activeButtonImage : inactiveButtonImage)
                     forState:UIControlStateSelected | UIControlStateHighlighted];
}

@end
