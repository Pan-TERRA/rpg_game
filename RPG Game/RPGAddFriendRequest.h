//
//  RPGAddFriendRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

extern NSString * const kRPGAddFriendRequestUserName;

@interface RPGAddFriendRequest : NSObject <RPGSerializable>

@property (nonatomic, copy, readonly) NSString *userName;

- (instancetype)initWithUserName:(NSString *)anUserName NS_DESIGNATED_INITIALIZER;
+ (instancetype)addFriendRequestWithUserName:(NSString *)anUserName;

@end
