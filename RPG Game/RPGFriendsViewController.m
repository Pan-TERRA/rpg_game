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
  // Constants
#import "RPGNibNames.h"
#import "RPGFriendsState.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"

@interface RPGFriendsViewController () <RPGFriendsTableViewControllerDelegate>

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

@end

@implementation RPGFriendsViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGFriendsViewControllerNIBName bundle:nil];
  if (self != nil)
  {
    _addFriendViewController = [RPGAddFriendViewController new];
    
    _friendsModelController = [RPGFriendsModelController new];
    [_friendsModelController setData:[self sampleData]];
    
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
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
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
  UIImage *activeButtonImage = [UIImage imageNamed:@"main_button_active"];
  UIImage *inactiveButtonImage = [UIImage imageNamed:@"main_button_inactive"];
  
  [aButton setBackgroundImage:(anActiveFlag ? activeButtonImage : inactiveButtonImage)
                     forState:UIControlStateNormal];
  [aButton setBackgroundImage:(!anActiveFlag ? activeButtonImage : inactiveButtonImage)
                     forState:UIControlStateSelected | UIControlStateHighlighted];
}

#pragma mark - Helper Methods

- (NSMutableArray<RPGFriend *> *)sampleData
{
  NSMutableArray *result = [NSMutableArray array];
  for (NSInteger i = 0; i < 25; i ++)
  {
    NSString *userName = [NSString stringWithFormat:@"UserName - %li", (long)i];
    NSString *characterName = [NSString stringWithFormat:@"CharacterName - %li", (long)i];
    NSString *avatar = @"forbidden";
    RPGFriendState state = i % 3;
    NSInteger level = (i * 5 + i % 3) % 11;
    BOOL online = i % 2;
    RPGFriend *friend = [RPGFriend friendWithID:i
                                       userName:userName
                                  characterName:characterName
                                         avatar:avatar
                                          state:state
                                          level:level
                                         online:online];
    [result addObject:friend];
  }
  
  return result;
}

#pragma mark - Accessors

- (void)setActiveState:(RPGFriendsListState)activeState
{
  if (_activeState != activeState)
  {
    _activeState = activeState;
    
    [self updateButtonsState];
    
    [self.friendsTableViewController setNeedReloadTableView];
  }
}

@end
