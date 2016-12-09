//
//  RPGFriendsTableViewCellOutgoing.m
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsTableViewCellOutgoing.h"

@implementation RPGFriendsTableViewCellOutgoing

@dynamic delegate;

- (IBAction)cancelFriendRequestButtonAction:(UIButton *)sender
{
  [self.delegate cancelFriendRequestButtonDidPressOnCell:self];
}

@end
