//
//  RPGNetworkManager+Quests.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

typedef NS_ENUM(NSUInteger, RPGQuestsState)
{
  kRPGQuestEmptyState = 0,
  kRPGQuestInProgressState,
  kRPGQuestIsDoneState,
  kRPGQuestReviewedState
};


@interface RPGNetworkManager (Quests)

- (void)fetchQuestsByState:(RPGQuestsState)aState completionHandler:(void (^)(NSInteger status, NSArray *quests))callbackBlock;

@end
