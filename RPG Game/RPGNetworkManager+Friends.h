//
//  RPGNetworkManager (Friends).h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

#import "RPGStatusCodes.h"

@class RPGFriendRequest;
@class RPGFriendConfirmRequest;

@interface RPGNetworkManager (Friends)

- (void)fetchFriendsWithCompletionHandler:(void (^)(RPGStatusCode status, NSArray *friends))callbackBlock;

- (void)addPlayerToFriendsWithRequest:(RPGFriendRequest *)aRequest
                    completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)confirmFriendWithRequest:(RPGFriendConfirmRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)postQuestChallengeWith:(RPGFriendRequest *)aRequest
         completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)confirmQuestChallengeWith:(RPGFriendConfirmRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode status))callbackBlock;
@end
