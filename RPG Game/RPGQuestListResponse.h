//
//  RPGQuestListResponse.h
//  RPG Game
//
//  Created by Максим Шульга on 10/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Entities
@class RPGQuest;
  // Constants
#import "RPGStatusCodes.h"

@interface RPGQuestListResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGStatusCode status;
@property (nonatomic, retain, readonly) NSArray<RPGQuest *> *quests;

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                        quests:(NSArray<RPGQuest *> *)aQuests NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                            quests:(NSArray<RPGQuest *> *)aQuests;

@end
