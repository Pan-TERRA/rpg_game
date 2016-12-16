//
//  RPGFriendsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsViewController.h"
  // Entity
#import "RPGFriend.h"
#import "RPGFriendsModelController.h"
  // View
#import "RPGAddFriendViewController.h"
#import "RPGFriendsTableViewController.h"
  // API
#import "RPGNetworkManager+Friends.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGFriendsState.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"
#import "UIViewController+RPGWrongTokenHandling.h"
#import "RPGAlertController.h"

typedef void (^fetchFriendsCompletionHandler)(RPGStatusCode, NSArray<NSDictionary *> *);

@interface RPGFriendsViewController () <RPGFriendsTableViewControllerDelegate,
                                        RPGAddFriendViewControllerDelegate>

  // Table View controls
@property (nonatomic, assign, readwrite) IBOutlet UIButton *allFriendButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *onlineFriendButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *incomingRequestsButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *outgoingRequestsButton;
  // Add Friend View Controller
@property (nonatomic, retain, readwrite) RPGAddFriendViewController *addFriendViewController;
  // Table View Controller
@property (nonatomic, assign, readwrite) IBOutlet UIView *tableViewContainer;
@property (nonatomic, retain, readwrite) RPGFriendsTableViewController *friendsTableViewController;
  // Model Controller
@property (nonatomic, retain, readwrite) RPGFriendsModelController *friendsModelController;
  // State
@property (nonatomic, assign, readwrite) RPGFriendsListState activeState;
@property (nonatomic, assign, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *emptyFriendListLabel;

@end

@implementation RPGFriendsViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGFriendsViewControllerNIBName bundle:nil];
  if (self != nil)
  {
    _addFriendViewController = [RPGAddFriendViewController new];
    _addFriendViewController.delegate = self;
    
    _friendsModelController = [RPGFriendsModelController new];
    
    _friendsTableViewController = [[RPGFriendsTableViewController alloc] initWithFriendsModelController:_friendsModelController];
    _friendsTableViewController.delegate = self;
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_addFriendViewController release];
  [_friendsTableViewController release];
  [_friendsModelController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.addFriendViewController.view removeFromSuperview];
  [self.addFriendViewController removeFromParentViewController];
  
  self.activeState = kRPGFriendListAllFriends;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self addChildViewController:self.friendsTableViewController view:self.tableViewContainer];
  
  [self fetchFriends];
}

#pragma mark - IBActions

- (IBAction)changeViewStateOnButtonClick:(UIButton *)aSender
{
  RPGFriendsListState newState = aSender.tag;
  
  self.activeState = newState;
}

- (IBAction)back:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showAddFriendView:(UIButton *)sender
{
  [self addChildViewController:self.addFriendViewController view:self.view];
}

#pragma mark - Network

- (void)fetchFriends
{
  [self setViewToWaitingForServerResponseState];
  
  fetchFriendsCompletionHandler handler = ^void(RPGStatusCode statusCode, NSArray *friendsList)
  {
    switch (statusCode)
    {
      case kRPGStatusCodeOK:
      {
        NSMutableArray<RPGFriend *> *friends = [NSMutableArray array];
        
        for (NSDictionary *friendDictionary in friendsList)
        {
          RPGFriend *friend = [[RPGFriend alloc] initWithDictionaryRepresentation:friendDictionary];
          [friends addObject:[friend autorelease]];
        }
        
        [self.friendsModelController setData:friends];
        [self.friendsTableViewController reloadTable];
        
        break;
      }
        
      case kRPGStatusCodeWrongToken:
      {
        [self handleWrongTokenError];
        
        break;
      }
        
      default:
      {
        NSString *message = @"Can't update friends list.";
        [RPGAlertController showAlertWithTitle:nil
                                       message:message
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
    }
    
    [self setViewToNormalState];
  };
  
  [[RPGNetworkManager sharedNetworkManager] fetchFriendsWithCompletionHandler:handler];
}

#pragma mark - Buttons state

- (void)updateButtonsState
{
  [self toggleButtonBackground:self.allFriendButton active:NO];
  [self toggleButtonBackground:self.onlineFriendButton active:NO];
  [self toggleButtonBackground:self.incomingRequestsButton active:NO];
  [self toggleButtonBackground:self.outgoingRequestsButton active:NO];

  switch (self.activeState)
  {
    case kRPGFriendListAllFriends:
    {
      [self toggleButtonBackground:self.allFriendButton active:YES];
      
      break;
    }
      
    case kRPGFriendListOnlineFriends:
    {
      [self toggleButtonBackground:self.onlineFriendButton active:YES];
      
      break;
    }
      
    case kRPGFriendListIncomingFriends:
    {
      [self toggleButtonBackground:self.incomingRequestsButton active:YES];
      
      break;
    }
      
    case kRPGFriendListOutgoingFriends:
    {
      [self toggleButtonBackground:self.outgoingRequestsButton active:YES];
      
      break;
    }
      
    default:
    {
      break;
    }
  }
}

- (void)toggleButtonBackground:(UIButton *)aButton active:(BOOL)anActiveFlag
{
  if (anActiveFlag)
  {
    UIImage *activeButtonImage = [UIImage imageNamed:@"main_button_active"];
    [aButton setBackgroundImage:activeButtonImage forState:UIControlStateNormal];
  }
  else
  {
    UIImage *inactiveButtonImage = [UIImage imageNamed:@"main_button_inactive"];
    [aButton setBackgroundImage:inactiveButtonImage forState:UIControlStateNormal];
  }
}

#pragma mark - View State

- (void)setViewToWaitingForServerResponseState
{
  [self.activityIndicator startAnimating];
}

- (void)setViewToNormalState
{
  [self.activityIndicator stopAnimating];
}

#pragma mark - RPGAddFriendViewControllerDelegate

- (void)friendDidAdd:(RPGAddFriendViewController *)anAddFriendViewController
{
  [self fetchFriends];
}

#pragma mark - RPGFriendsTableViewControllerDelegate

- (void)needUpdateFriendsList:(RPGFriendsTableViewController *)friendsTableViewController
{
  [self fetchFriends];
}

- (void)friendsListIsEmpty:(BOOL)aFlag friendTableViewController:(RPGFriendsTableViewController *)friendTableViewController
{
  self.emptyFriendListLabel.hidden = !aFlag;
}

#pragma mark - Accessors

- (void)setActiveState:(RPGFriendsListState)activeState
{
  if (_activeState != activeState)
  {
    _activeState = activeState;
    
    [self updateButtonsState];
    [self.friendsTableViewController reloadTable];
  }
}

@end
