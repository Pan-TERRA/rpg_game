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
  // Constants
#import "RPGNibNames.h"

static NSString * const sInFriendsCellReusableIdentifier = @"inFriendsIdentifier";
static NSString * const sIncomingCellReusableIdentifier = @"incomingIdentifier";
static NSString * const sOutgoingCellReusableIdentifier = @"outgoingIdentifier";

@interface RPGFriendsTableViewController ()

@end

@implementation RPGFriendsTableViewController

#pragma mark - Init

- (instancetype)initWithFriendsModelController:(RPGFriendsModelController *)aModelController
{
  self = [super init];
  if (self != nil)
  {
    _friendsModelController = aModelController;
  }
  return self;
}


#pragma mark - Dealloc

- (void)dealloc
{
  [_friendsModelController release];
  
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

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

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
  return cell;
}

#pragma mark - API

- (void)setNeedReloadTableView
{
  [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
