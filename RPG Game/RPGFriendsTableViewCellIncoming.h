//
//  RPGFriendsTableViewCellIncoming.h
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsBasicTableViewCell.h"

@class RPGFriendsTableViewCellIncoming;

@protocol RPGFriendsTableViewCellIncomingDelegate <NSObject>

- (void)acceptFriendRequestButtonDidPressOnCell:(RPGFriendsTableViewCellIncoming *)aCell;
- (void)skipFriendRequestButtonDidPressOnCell:(RPGFriendsTableViewCellIncoming *)aCell;

@end

@interface RPGFriendsTableViewCellIncoming : RPGFriendsBasicTableViewCell

@property (nonatomic, assign, readwrite) id<RPGFriendsTableViewCellIncomingDelegate> delegate;

@end
