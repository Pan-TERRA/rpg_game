//
//  RPGQuestChallengeRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

extern NSString * const kRPGQuestChallengeRequestFriendID;

@interface RPGQuestChallengeRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger friendID;

- (instancetype)initWithFriendID:(NSInteger)aFriendID NS_DESIGNATED_INITIALIZER;
+ (instancetype)questChallengeRequestWithFriendID:(NSInteger)aFriendID;

@end
