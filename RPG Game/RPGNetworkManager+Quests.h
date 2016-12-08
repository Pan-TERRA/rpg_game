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
  // Entities
@class RPGQuestRequest;
@class RPGQuestReviewRequest;
@class RPGQuestListResponse;

@interface RPGNetworkManager (Quests)

- (void)fetchQuestsByState:(RPGQuestListState)aState
         completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                     RPGQuestListResponse *aResponse))aCallback;

- (void)doQuestAction:(RPGQuestAction)anAction
              request:(RPGQuestRequest *)aRequest
    completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

- (void)addProofWithRequest:(RPGQuestRequest *)aRequest
                  imageData:(NSData *)anImageData
          completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

- (void)postQuestProofWithRequest:(RPGQuestReviewRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

- (void)getQuestRewardWithRequest:(RPGQuestRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

@end
