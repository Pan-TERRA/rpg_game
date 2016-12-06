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
  // Cells
#import "RPGFriendsBasicTableViewCell.h"
#import "RPGFriendsTableViewCellInFriends.h"
#import "RPGFriendsTableViewCellIncoming.h"
#import "RPGFriendsTableViewCellOutgoing.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGFriendsState.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"

static NSString * const sInFriendsCellReusableIdentifier = @"inFriendsIdentifier";
static NSString * const sIncomingCellReusableIdentifier = @"incomingIdentifier";
static NSString * const sOutgoingCellReusableIdentifier = @"outgoingIdentifier";

@interface RPGFriendsViewController () <UITableViewDelegate, UITableViewDataSource>

  // TableView controls
@property (nonatomic, assign, readwrite) IBOutlet UIButton *allFriendButton;
@property (nonatomic, assign, readwrite)IBOutlet UIButton *onlineFriendButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *incomingRequestsButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *outgoingRequestsButton;
  // add friend
@property (nonatomic, retain, readwrite) IBOutlet UIViewController *addFriendViewController;
@property (nonatomic, assign, readwrite) IBOutlet UITextField *friendNickNameTextField;
  // dataSource
@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *allFriends;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *onlineFriends;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *incomingRequest;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *outgoingRequest;

@property (nonatomic, assign, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, assign, readwrite) RPGFriendsListState activeState;

@end

@implementation RPGFriendsViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGFriendsViewControllerNIBName bundle:nil];
  if (self != nil)
  {
    _allFriends = [NSMutableArray new];
    _onlineFriends = [NSMutableArray new];
    _incomingRequest = [NSMutableArray new];
    _outgoingRequest = [NSMutableArray new];
    
    _activeState = kRPGFriendListAllFriends;
    
    [self sampleData];
    [self sortAllFriendsMutableArray];
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_allFriends release];
  [_onlineFriends release];
  [_incomingRequest release];
  [_outgoingRequest release];

  [_addFriendViewController release];
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.addFriendViewController.view removeFromSuperview];
  [self.addFriendViewController removeFromParentViewController];
  
  [self setActiveButtonForState:self.activeState];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
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
  [self setActiveButtonForState:newState];
}

- (IBAction)back:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showAddFriendView:(UIButton *)sender
{
  [self addChildViewController:self.addFriendViewController view:self.view];
  [self.friendNickNameTextField becomeFirstResponder];
}

- (IBAction)confirmAddFriend:(UIButton *)sender
{
  
}

- (IBAction)closeAddFriendView:(UIButton *)sender
{
  [self.addFriendViewController.view removeFromSuperview];
  [self.addFriendViewController removeFromParentViewController];
}

#pragma mark - UITableViewDataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger numberOfRow = 0;
  switch (self.activeState)
  {
    case kRPGFriendListAllFriends:
    {
      numberOfRow = self.allFriends.count;
      
      break;
    }
      
    case kRPGFriendListOnlineFriends:
    {
      numberOfRow = self.onlineFriends.count;
      
      break;
    }
      
    case kRPGFriendListIncomingFriends:
    {
      numberOfRow = self.incomingRequest.count;
      
      break;
    }
      
    case kRPGFriendListOutgoingFriends:
    {
      numberOfRow = self.outgoingRequest.count;
      
      break;
    }
    default:
    {
      break;
    }
  }
  return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  RPGFriendsBasicTableViewCell *cell = nil;
  RPGFriend *friend = nil;
  switch (self.activeState)
  {
    case kRPGFriendListAllFriends:
    {
      friend = self.allFriends[indexPath.item];
      cell = [self cellWithTableView:tableView forFriendState:friend.state];
      
      break;
    }
      
    case kRPGFriendListOnlineFriends:
    {
      friend = self.onlineFriends[indexPath.item];
      cell = [self cellWithTableView:tableView forFriendState:friend.state];
      
      break;
    }
      
    case kRPGFriendListIncomingFriends:
    {
      friend = self.incomingRequest[indexPath.item];
      cell = [self cellWithTableView:tableView forFriendState:friend.state];
      
      break;
    }
      
    case kRPGFriendListOutgoingFriends:
    {
      friend = self.outgoingRequest[indexPath.item];
      cell = [self cellWithTableView:tableView forFriendState:friend.state];

      break;
    }
      
    default:
    {
      cell = [(RPGFriendsBasicTableViewCell *)[UITableViewCell new] autorelease];
      break;
    }
  }
  
  cell.currentFriend = friend;
  
  return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Buttons state

- (void)setActiveButtonForState:(RPGFriendsListState)aState
{
  self.activeState = aState;
  
  [self toggleButtonBackground:self.allFriendButton active:NO];
  [self toggleButtonBackground:self.onlineFriendButton active:NO];
  [self toggleButtonBackground:self.incomingRequestsButton active:NO];
  [self toggleButtonBackground:self.outgoingRequestsButton active:NO];

  switch (aState)
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
  [self.tableView reloadData];
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

- (void)sampleData
{
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
    switch (friend.state)
    {
      case kRPGFriendStateAccept:
      {
        if (friend.isOnline)
        {
          [self.onlineFriends addObject:friend];
        }
        break;
      }
        
      case kRPGFriendStateIncoming:
      {
        [self.incomingRequest addObject:friend];
        break;
      }
        
      case kRPGFriendStateOutgoing:
      {
        [self.outgoingRequest addObject:friend];
        break;
      }
    }
    [self.allFriends addObject:friend];
  }
}

- (RPGFriendsBasicTableViewCell *)cellWithTableView:(UITableView *)aTableView forFriendState:(RPGFriendState)aState
{
  RPGFriendsBasicTableViewCell *cell = nil;
  
  switch (aState)
  {
    case kRPGFriendStateAccept:
    {
      cell = [aTableView dequeueReusableCellWithIdentifier:sInFriendsCellReusableIdentifier];
      if (cell == nil)
      {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kRPGFriendsTableViewCellInFriendsNIBName
                                                     owner:self
                                                   options:nil];
        cell = nib.firstObject;
      }
      break;
    }
      
    case kRPGFriendStateIncoming:
    {
      cell = [aTableView dequeueReusableCellWithIdentifier:sIncomingCellReusableIdentifier];
      
      if (cell == nil)
      {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kRPGFriendsTableViewCellIncomingNIBName
                                                     owner:self
                                                   options:nil];
        cell = nib.firstObject;
      }
      break;
    }
      
    case kRPGFriendStateOutgoing:
    {
      cell = [aTableView dequeueReusableCellWithIdentifier:sOutgoingCellReusableIdentifier];
      
      if (cell == nil)
      {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kRPGFriendsTableViewCellOutgoingNIBName
                                                     owner:self
                                                   options:nil];
        cell = nib.firstObject;
      }
      break;
    }
      
    default:
    {
      break;
    }
  }
  return cell;
}

- (void)sortAllFriendsMutableArray
{
  NSArray *sortedArray = [self.allFriends sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
 {
   NSNumber *first = @(((RPGFriend *)obj1).state);
   NSNumber *second = @(((RPGFriend *)obj2).state);
   NSComparisonResult result = [first compare:second];
   
   //if state is equal - check for online
   if (result == NSOrderedSame)
   {
     first = @(((RPGFriend *)obj1).online);
     second = @(((RPGFriend *)obj2).online);
     result = [second compare:first];
   }
   
   return result;
 }];
  
  self.allFriends = [NSMutableArray arrayWithArray:sortedArray];
}

@end
