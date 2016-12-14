//
//  RPGFriendsTableViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsTableViewController.h"
  // Entities
#import "RPGFriend.h"
#import "RPGFriendsModelController.h"
  // Cells
#import "RPGFriendsBasicTableViewCell.h"
#import "RPGFriendsTableViewCellInFriends.h"
#import "RPGFriendsTableViewCellIncoming.h"
#import "RPGFriendsTableViewCellOutgoing.h"
  // API
#import "RPGNetworkManager+Friends.h"
  // Network Entity
#import "RPGFriendRequest.h"
  // Constants
#import "RPGNibNames.h"
  // Misc
#import "RPGAlertController.h"
#import "UIViewController+RPGWrongTokenHandling.h"

static NSString * const sInFriendsCellReusableIdentifier = @"inFriendsIdentifier";
static NSString * const sIncomingCellReusableIdentifier = @"incomingIdentifier";
static NSString * const sOutgoingCellReusableIdentifier = @"outgoingIdentifier";

static CGFloat const sRPGFriendsTableViewControllerRowHeight = 115.0;

@interface RPGFriendsTableViewController () <RPGFriendsTableViewCellInFriendsDelegate,
                                             RPGFriendsTableViewCellIncomingDelegate,
                                             RPGFriendsTableViewCellOutgoingDelegate>

@end

@implementation RPGFriendsTableViewController

#pragma mark - Init

- (instancetype)initWithFriendsModelController:(RPGFriendsModelController *)aModelController
{
  self = [super init];
  if (self != nil)
  {
    _friendsModelController = aModelController;
    self.tableView.rowHeight = sRPGFriendsTableViewControllerRowHeight;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
  }
  return self;
}


#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - UITableViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger numberOfRow = 0;
  switch (self.delegate.activeState)
  {
    case kRPGFriendListAllFriends:
    {
      numberOfRow = self.friendsModelController.allFriends.count;
      
      break;
    }
      
    case kRPGFriendListOnlineFriends:
    {
      numberOfRow = self.friendsModelController.onlineFriends.count;
      
      break;
    }
      
    case kRPGFriendListIncomingFriends:
    {
      numberOfRow = self.friendsModelController.incomingRequests.count;
      
      break;
    }
      
    case kRPGFriendListOutgoingFriends:
    {
      numberOfRow = self.friendsModelController.outgoingRequests.count;
      
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
  
  switch (self.delegate.activeState)
  {
    case kRPGFriendListAllFriends:
    {
      friend = self.friendsModelController.allFriends[indexPath.item];
      cell = [self cellWithTableView:tableView forFriendState:friend.state];
      
      break;
    }
      
    case kRPGFriendListOnlineFriends:
    {
      friend = self.friendsModelController.onlineFriends[indexPath.item];
      cell = [self cellWithTableView:tableView forFriendState:friend.state];
      
      break;
    }
      
    case kRPGFriendListIncomingFriends:
    {
      friend = self.friendsModelController.incomingRequests[indexPath.item];
      cell = [self cellWithTableView:tableView forFriendState:friend.state];
      
      break;
    }
      
    case kRPGFriendListOutgoingFriends:
    {
      friend = self.friendsModelController.outgoingRequests[indexPath.item];
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

#pragma mark - Helper Methods

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
  cell.delegate = self;
  
  return cell;
}

#pragma mark - API

- (void)reloadTable
{
  [self.tableView reloadData];
}

#pragma mark - Cells Delegate

- (void)questChallengeButtonDidPressOnCell:(RPGFriendsTableViewCellInFriends *)aCell
{
  NSInteger friendID = aCell.currentFriend.friendID;
  RPGFriendRequest *request = [RPGFriendRequest friendRequestWithFriendID:friendID];
  
  [[RPGNetworkManager sharedNetworkManager] doFriendAction:kRPGFriendsNetworkActionSendChallengeRequest
                                               withRequest:request
                                         completionHandler:^(RPGStatusCode status)
   {
     switch (status)
     {
       case kRPGStatusCodeOK:
       {
         [RPGAlertController showAlertWithTitle:@"Success"
                                        message:@"The request was submitted successfully"
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [self handleWrongTokenError];
         
         break;
       }
         
       case kRPGStatusCodeFriendNotFound:
       {
         [self handleFriendNotFound];
         
         break;
       }
         
        case kRPGStatusCodeQuestDuelCannotBeSent:
       {
         [self handleQuestDuelCannotBeSent];
         break;
       }

       default:
       {
         [self handleDefaultError];
         
         break;
       }
     }
     [self.delegate needUpdateFriendsList:self];
   }];
}

- (void)removeFromFriendsButtonDidPressOnCell:(RPGFriendsTableViewCellInFriends *)aCell
{
  NSInteger friendID = aCell.currentFriend.friendID;
  RPGFriendRequest *request = [RPGFriendRequest friendRequestWithFriendID:friendID];
  
  [[RPGNetworkManager sharedNetworkManager] doFriendAction:kRPGFriendsNetworkActionDeleteFriendRequest
                                               withRequest:request
                                         completionHandler:^(RPGStatusCode status)
   {
     switch (status)
     {
       case kRPGStatusCodeOK:
       {
         [RPGAlertController showAlertWithTitle:@"Success"
                                        message:@"You remove this user from friends"
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [self handleWrongTokenError];
         
         break;
       }
         
       case kRPGStatusCodeFriendNotFound:
       {
         [self handleFriendNotFound];
         
         break;
       }
         
       default:
       {
         [self handleDefaultError];
         
         break;
       }
     }
     [self.delegate needUpdateFriendsList:self];
   }];
}

- (void)acceptFriendRequestButtonDidPressOnCell:(RPGFriendsTableViewCellIncoming *)aCell
{
  NSInteger friendID = aCell.currentFriend.friendID;
  RPGFriendRequest *request = [RPGFriendRequest friendRequestWithFriendID:friendID];

  [[RPGNetworkManager sharedNetworkManager] doFriendAction:kRPGFriendsNetworkActionAcceptFriendRequest
                                               withRequest:request
                                         completionHandler:^(RPGStatusCode status)
   {
     switch (status)
     {
       case kRPGStatusCodeOK:
       {
         [RPGAlertController showAlertWithTitle:@"Success"
                                        message:@"You accept this request"
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [self handleWrongTokenError];
         
         break;
       }
         
       case kRPGStatusCodeAreAlreadyFriends:
       {
         [self handleAreAlreadyFriends];
         
         break;
       }
         
       case kRPGStatusCodeFriendRequestNotFound:
       {
         [self handleFriendRequestNotFound];
         
         break;
       }
         
       default:
       {
         [self handleDefaultError];
         
         break;
       }
     }
     [self.delegate needUpdateFriendsList:self];
   }];
}

- (void)skipFriendRequestButtonDidPressOnCell:(RPGFriendsTableViewCellIncoming *)aCell
{
  NSInteger friendID = aCell.currentFriend.friendID;
  RPGFriendRequest *request = [RPGFriendRequest friendRequestWithFriendID:friendID];

  [[RPGNetworkManager sharedNetworkManager] doFriendAction:kRPGFriendsNetworkActionSkipFriendRequest
                                               withRequest:request
                                         completionHandler:^(RPGStatusCode status)
   {
     switch (status)
     {
       case kRPGStatusCodeOK:
       {
         [RPGAlertController showAlertWithTitle:@"Success"
                                        message:@"You refuse this request"
                                    actionTitle:nil
                                     completion:nil];
         break;
       }
         
       case kRPGStatusCodeWrongToken:
       {
         [self handleWrongTokenError];
         
         break;
       }
         
       case kRPGStatusCodeFriendRequestNotFound:
       {
         [self handleFriendRequestNotFound];
         
         break;
       }
         
       default:
       {
         [self handleDefaultError];
         
         break;
       }
     }
     [self.delegate needUpdateFriendsList:self];
   }];
}

- (void)cancelFriendRequestButtonDidPressOnCell:(RPGFriendsTableViewCellOutgoing *)aCell
{
  NSInteger friendID = aCell.currentFriend.friendID;
  RPGFriendRequest *request = [RPGFriendRequest friendRequestWithFriendID:friendID];

  [[RPGNetworkManager sharedNetworkManager] doFriendAction:kRPGFriendsNetworkActionCancelFriendRequest
                                               withRequest:request
                                         completionHandler:^(RPGStatusCode status)
  {
    switch (status)
    {
      case kRPGStatusCodeOK:
      {
        [RPGAlertController showAlertWithTitle:@"Success"
                                       message:@"Request canceled"
                                   actionTitle:nil
                                    completion:nil];
        break;
      }
        
      case kRPGStatusCodeWrongToken:
      {
        [self handleWrongTokenError];
        
        break;
      }
        
      case kRPGStatusCodeFriendRequestNotFound:
      {
        [self handleFriendRequestNotFound];
        
        break;
      }
        
      default:
      {
        [self handleDefaultError];
        
        break;
      }
    }
    [self.delegate needUpdateFriendsList:self];
  }];
}

#pragma mark - Error Handling

- (void)handleFriendRequestNotFound
{
  [RPGAlertController showAlertWithTitle:nil
                                 message:@"Request not found"
                             actionTitle:nil
                              completion:nil];
}

- (void)handleDefaultError
{
  [RPGAlertController showAlertWithTitle:nil
                                 message:@"Unknown error"
                             actionTitle:nil
                              completion:nil];

}

- (void)handleAreAlreadyFriends
{
  [RPGAlertController showAlertWithTitle:nil
                                 message:@"Are already friends"
                             actionTitle:nil
                              completion:nil];
}

- (void)handleFriendNotFound
{
  [RPGAlertController showAlertWithTitle:nil
                                 message:@"Friend not found"
                             actionTitle:nil
                              completion:nil];
}

- (void)handleQuestDuelCannotBeSent
{
  [RPGAlertController showAlertWithTitle:nil
                                 message:@"Request cannot be sended"
                             actionTitle:nil
                              completion:nil];
}
@end
