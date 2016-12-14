//
//  RPGNetworkManager+Quests.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Constants
#import "RPGQuestListState.h"
#import "RPGQuestAction.h"
#import "RPGQuestEnum.h"
  // Entities
@class RPGQuestRequest;
@class RPGDuelQuestRequest;
@class RPGQuestReviewRequest;
@class RPGQuestListResponse;
@class RPGIncomingDuelQuestListResponse;

@interface RPGNetworkManager (Quests)

- (void)fetchQuestsByType:(RPGQuestType)aType
                    state:(RPGQuestListState)aState
        completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                    RPGQuestListResponse *aResponse))aCallback;

- (void)doQuestAction:(RPGQuestAction)anAction
               byType:(RPGQuestType)aType
              request:(RPGQuestRequest *)aRequest
    completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

- (void)addProofByType:(RPGQuestType)aType
               request:(RPGQuestRequest *)aRequest
             imageData:(NSData *)anImageData
     completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

- (void)postQuestProofWithRequest:(RPGQuestReviewRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

- (void)getQuestRewardWithRequest:(RPGQuestRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

@end
