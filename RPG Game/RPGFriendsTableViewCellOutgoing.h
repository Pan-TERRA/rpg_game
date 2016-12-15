//
//  RPGFriendsTableViewCellOutgoing.h
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsBasicTableViewCell.h"

@class RPGFriendsTableViewCellOutgoing;

@protocol RPGFriendsTableViewCellOutgoingDelegate <NSObject>

- (void)cancelFriendRequestButtonDidPressOnCell:(RPGFriendsTableViewCellOutgoing *)aCell;

@end

@interface RPGFriendsTableViewCellOutgoing : RPGFriendsBasicTableViewCell

@property (nonatomic, assign, readwrite) id<RPGFriendsTableViewCellOutgoingDelegate> delegate;

@end
