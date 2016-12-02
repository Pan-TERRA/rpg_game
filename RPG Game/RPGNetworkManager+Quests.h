//
//  RPGNetworkManager+Quests.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGQuestListState.h"
#import "RPGQuestAction.h"

@class RPGQuestRequest;
@class RPGQuestReviewRequest;

@interface RPGNetworkManager (Quests)

- (void)fetchQuestsByState:(RPGQuestListState)aState
         completionHandler:(void (^)(NSInteger status, NSArray *quests))aCallback;

- (void)doQuestAction:(RPGQuestAction)anAction
              request:(RPGQuestRequest *)aRequest
    completionHandler:(void (^)(NSInteger status))aCallback;

- (void)addProofWithRequest:(RPGQuestRequest *)aRequest
                  imageData:(NSData *)anImageData
          completionHandler:(void (^)(NSInteger status))aCallback;

- (void)postQuestProofWithRequest:(RPGQuestReviewRequest *)aRequest
                completionHandler:(void (^)(NSInteger status))aCallback;

@end
