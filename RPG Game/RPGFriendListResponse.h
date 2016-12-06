//
//  RPGFriendListResponse.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBasicNetworkResponse.h"

extern NSString * const kRPGFriendsListResponseFriends;

@interface RPGFriendListResponse : RPGBasicNetworkResponse <RPGSerializable>

@property (nonatomic, retain, readonly) NSArray *friends;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                        friends:(NSArray *)aFriends NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                            friends:(NSArray *)aFriends;

@end
