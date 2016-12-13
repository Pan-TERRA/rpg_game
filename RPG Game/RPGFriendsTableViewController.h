//
//  RPGFriendsTableViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGFriendsState.h"

@class RPGFriendsModelController;
@class RPGFriendsTableViewController;

@protocol RPGFriendsTableViewControllerDelegate <NSObject>

@property (nonatomic, assign, readonly) RPGFriendsListState activeState;

- (void)needUpdateFriendsList:(RPGFriendsTableViewController *)friendsTableViewController;

@end


@interface RPGFriendsTableViewController : UITableViewController

@property (nonatomic, assign, readwrite) id<RPGFriendsTableViewControllerDelegate> delegate;
@property (nonatomic, assign, readwrite) RPGFriendsModelController *friendsModelController;

- (instancetype)initWithFriendsModelController:(RPGFriendsModelController *)aModelController;

- (void)reloadTable;

@end
