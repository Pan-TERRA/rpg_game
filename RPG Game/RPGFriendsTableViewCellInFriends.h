//
//  RPGFriendsTableViewCellInFriends.h
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsBasicTableViewCell.h"

@class RPGFriendsTableViewCellInFriends;

@protocol RPGFriendsTableViewCellInFriendsDelegate <NSObject>

- (void)questChallengeButtonDidPressOnCell:(RPGFriendsTableViewCellInFriends *)aCell;
- (void)removeFromFriendsButtonDidPressOnCell:(RPGFriendsTableViewCellInFriends *)aCell;

@end

@interface RPGFriendsTableViewCellInFriends : RPGFriendsBasicTableViewCell

@property (nonatomic, assign, readwrite) id<RPGFriendsTableViewCellInFriendsDelegate> delegate;

@end
