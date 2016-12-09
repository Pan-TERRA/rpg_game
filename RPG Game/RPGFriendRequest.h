//
//  RPGFriendRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

extern NSString * const kRPGFriendRequestFriendID;

@interface RPGFriendRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger friendID;

- (instancetype)initWithFriendID:(NSInteger)aFriendID NS_DESIGNATED_INITIALIZER;
+ (instancetype)friendRequestWithFriendID:(NSInteger)aFriendID;

@end
