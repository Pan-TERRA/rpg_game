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

typedef NS_ENUM(NSUInteger, RPGFriendsNetworkAction)
{
  kRPGFriendsNetworkActionCancelFriendRequest,
  kRPGFriendsNetworkActionDeleteFriendRequest,
  kRPGFriendsNetworkActionAcceptFriendRequest,
  kRPGFriendsNetworkActionSkipFriendRequest
};

@interface RPGNetworkManager (Friends)

- (void)fetchFriendsWithCompletionHandler:(void (^)(RPGStatusCode status, NSArray *friends))callbackBlock;

- (void)addPlayerToFriendsWithRequest:(RPGFriendRequest *)aRequest
                    completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)doFriendAction:(RPGFriendsNetworkAction)anAction
           withRequest:(RPGFriendRequest *)aRequest
     completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)postQuestChallengeWith:(RPGFriendRequest *)aRequest
         completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)confirmQuestChallengeWith:(RPGFriendConfirmRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

@end
