//
//  RPGNetworkManager (Friends).h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Entities
@class RPGFriendRequest;
@class RPGAddFriendRequest;
  // Constants
#import "RPGStatusCodes.h"

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
                    completionHandler:(void (^)(RPGStatusCode aStatus))aCallback;

- (void)doFriendAction:(RPGFriendsNetworkAction)anAction
           withRequest:(RPGFriendRequest *)aRequest
     completionHandler:(void (^)(RPGStatusCode aStatus))aCallback;

- (void)postQuestChallengeWith:(RPGFriendRequest *)aRequest
         completionHandler:(void (^)(RPGStatusCode aStatus))aCallback;

- (void)confirmQuestChallengeWith:(RPGAddFriendRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode aStatus))aCallback;

@end
