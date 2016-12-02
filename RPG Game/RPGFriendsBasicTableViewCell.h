//
//  RPGFriendsBasicTableViewCell.h
//  RPG Game
//
//  Created by Владислав Крут on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGFriend;

@interface RPGFriendsBasicTableViewCell : UITableViewCell

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *avatar;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *onlineImage;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *levelLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *nicknameLabel;

@property (nonatomic, retain, readwrite) RPGFriend *currentFriend;

@end
