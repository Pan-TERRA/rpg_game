//
//  RPGConfirmQuestChallengeRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGConfirmChallengeRequest : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger friendID;
@property (nonatomic, assign, readonly) BOOL result;

- (instancetype)initWithFriendID:(NSInteger)aFriendID
                          result:(BOOL)aResult NS_DESIGNATED_INITIALIZER;
+ (instancetype)confirmChallengeRequestWithFriendID:(NSInteger)aFriendID
                                             result:(BOOL)aResult;


@end
