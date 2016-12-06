//
//  RPGFriendConfirmRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendRequest.h"

extern NSString * const kRPGFriendConfirmRequestResult;

@interface RPGFriendConfirmRequest : RPGFriendRequest <RPGSerializable>

@property (nonatomic, assign, readonly) BOOL result;

- (instancetype)initWithFriendID:(NSInteger)aFriendID
                          result:(BOOL)aResult NS_DESIGNATED_INITIALIZER;
+ (instancetype)friendConfirmRequestWithFriendID:(NSInteger)aFriendID
                                      result:(BOOL)aResult;

@end
