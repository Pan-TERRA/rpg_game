//
//  RPGFriendsModelController.h
//  RPG Game
//
//  Created by Владислав Крут on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPGFriend;

@interface RPGFriendsModelController : NSObject

@property (nonatomic, retain, readonly) NSArray<RPGFriend *> *allFriends;
@property (nonatomic, retain, readonly) NSArray<RPGFriend *> *onlineFriends;
@property (nonatomic, retain, readonly) NSArray<RPGFriend *> *incomingRequests;
@property (nonatomic, retain, readonly) NSArray<RPGFriend *> *outgoingRequests;

- (instancetype)initWithFriends:(NSArray<RPGFriend *> *)aFriends;
+ (instancetype)modelControllerWithFriends:(NSArray<RPGFriend *> *)aFriends;

- (void)setData:(NSArray<RPGFriend *> *)aFriends;

@end
