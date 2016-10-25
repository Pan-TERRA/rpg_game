//
//  RPGNetworkManager+Quests.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGQuestListState.h"

@class RPGQuestRequest;

@interface RPGNetworkManager (Quests)

- (void)fetchQuestsByState:(RPGQuestListState)aState completionHandler:(void (^)(NSInteger status, NSArray *quests))callbackBlock;
- (void)takeQuestWithRequest:(RPGQuestRequest *)aRequest completionHandler:(void (^)(NSInteger status))callbackBlock;
- (void)addProofWithRequest:(RPGQuestRequest *)aRequest imageData:(NSData *)imageData completionHandler:(void (^)(NSInteger status))callbackBlock;
- (void)getImageProofDataFromURL:(NSURL *)url completionHandler:(void (^)(NSData *imageData))callbackBlock;

@end
