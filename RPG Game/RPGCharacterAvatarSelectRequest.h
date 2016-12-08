//
//  RPGChooseAvatarRequest.h
//  RPG Game
//
//  Created by Максим Шульга on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGCharacterAvatarSelectRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger avatarID;

- (instancetype)initWithAvatarID:(NSInteger)anAvatarID NS_DESIGNATED_INITIALIZER;
+ (instancetype)characterAvatarSelectRequestWithAvatarID:(NSInteger)anAvatarID;

@end