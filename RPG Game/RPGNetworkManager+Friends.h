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
@class RPGAddFriendRequest;

typedef NS_ENUM(NSUInteger, RPGFriendsNetworkAction)
{
  kRPGFriendsNetworkActionCancelFriendRequest,
  kRPGFriendsNetworkActionDeleteFriendRequest,
  kRPGFriendsNetworkActionAcceptFriendRequest,
  kRPGFriendsNetworkActionSkipFriendRequest
};

@interface RPGNetworkManager (Friends)

- (void)fetchFriendsWithCompletionHandler:(void (^)(RPGStatusCode status, NSArray<NSDictionary *> *friends))callbackBlock;

- (void)addPlayerToFriendsWithRequest:(RPGAddFriendRequest *)aRequest
                    completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)doFriendAction:(RPGFriendsNetworkAction)anAction
           withRequest:(RPGFriendRequest *)aRequest
     completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)postQuestChallengeWith:(RPGFriendRequest *)aRequest
         completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

- (void)confirmQuestChallengeWith:(RPGAddFriendRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode status))callbackBlock;

@end
