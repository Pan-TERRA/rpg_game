//
//  RPGFriendsTableViewCellInFriends.m
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsTableViewCellInFriends.h"

@implementation RPGFriendsTableViewCellInFriends

- (IBAction)questChallengeButtonAction:(UIButton *)sender
{
  [self.delegate questChallengeButtonDidPressOnCell:self];
}

- (IBAction)removeFromFriendsButtonAction:(UIButton *)sender
{
  [self.delegate removeFromFriendsButtonDidPressOnCell:self];
}

@end
