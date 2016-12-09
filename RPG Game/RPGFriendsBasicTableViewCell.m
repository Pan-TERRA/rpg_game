//
//  RPGFriendsBasicTableViewCell.m
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsBasicTableViewCell.h"
  // Entity
#import "RPGFriend.h"

@interface RPGFriendsBasicTableViewCell ()

@end

@implementation RPGFriendsBasicTableViewCell

#pragma mark - Dealloc

- (void)dealloc
{
  [_currentFriend release];
  
  [super dealloc];
}

#pragma mark - UITableViewCell

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

#pragma mark - Accessors

- (void)setCurrentFriend:(RPGFriend *)aFriend
{
  if (_currentFriend != aFriend)
  {
    [_currentFriend release];
    _currentFriend = [aFriend retain];
    
    NSString *imageName = [NSString stringWithFormat:@"avatar_%ld_%ld", aFriend.classID, aFriend.avatarID];
    self.avatar.image = [UIImage imageNamed:imageName];
    
    UIImage *onlineStatus = nil;
    switch (aFriend.state)
    {
      case kRPGFriendStateAccept:
      {
        if (aFriend.isOnline)
        {
          onlineStatus = [UIImage imageNamed:@"online"];
        }
        else
        {
          onlineStatus = [UIImage imageNamed:@"offline"];
        }
        break;
      }
      case kRPGFriendStateIncoming:
      {
        onlineStatus = [UIImage imageNamed:@"incoming"];
        break;
      }
      case kRPGFriendStateOutgoing:
      {
        onlineStatus = [UIImage imageNamed:@"outgoing"];
        break;
      }
      default:
      {
        break;
      }
    }
   
    self.onlineImage.image = onlineStatus;
    
    self.levelLabel.text = [@(aFriend.level) stringValue];
    
    NSString *nickName = [NSString stringWithFormat:@"%@ - %@", aFriend.userName, aFriend.characterName];
    
    self.nicknameLabel.text = nickName;
  }
}

@end
