//
//  RPGFriendAddRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

extern NSString * const kRPGFriendAddRequestFriendID;

@interface RPGFriendAddRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger friendID;

- (instancetype)initWithFriendID:(NSInteger)aFriendID NS_DESIGNATED_INITIALIZER;
+ (instancetype)addFriendRequestWithFriendID:(NSInteger)aFriendID;

@end
