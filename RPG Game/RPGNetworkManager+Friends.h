//
//  RPGNetworkManager (Friends).h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

#import "RPGStatusCodes.h"

@class RPGFriendAddRequest;
@class RPGFriendConfirmRequest;
@class RPGQuestChallengeRequest;
@class RPGConfirmChallengeRequest;


@interface RPGNetworkManager (Friends)

- (void)fetchFriendsWithCompletionHandler:(void (^)(RPGStatusCode status, NSArray *friends))callbackBlock;

- (void)addPlayerToFriendsWithRequest:(RPGFriendAddRequest *)aRequest
                    completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)confirmFriendWithRequest:(RPGFriendConfirmRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)postQuestChallengeWith:(RPGQuestChallengeRequest *)aRequest
         completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)confirmQuestChallengeWith:(RPGConfirmChallengeRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode status))callbackBlock;
@end
