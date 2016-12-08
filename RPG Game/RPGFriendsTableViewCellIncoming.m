//
//  RPGFriendsTableViewCellIncoming.m
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsTableViewCellIncoming.h"

@implementation RPGFriendsTableViewCellIncoming

- (IBAction)acceptFriendRequestButtonAction:(UIButton *)sender
{
  [self.delegate acceptFriendRequestButtonDidPressOnCell:self];
}

- (IBAction)skipFriendRequestButtonAction:(UIButton *)sender
{
  [self.delegate skipFriendRequestButtonDidPressOnCell:self];
}

@end
