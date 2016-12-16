//
//  RPGIncomingDuelQuestListResponse.h
//  RPG Game
//
//  Created by Максим Шульга on 12/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListResponse.h"
  // Entities
@class RPGIncomingDuelQuest;

@interface RPGIncomingDuelQuestListResponse : RPGQuestListResponse

- (instancetype)initWithStatus:(NSInteger)aStatus
                incomingQuests:(NSArray<RPGIncomingDuelQuest *> *)anIncomingQuests NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(NSInteger)aStatus
                    incomingQuests:(NSArray<RPGIncomingDuelQuest *> *)anIncomingQuests;

@end
