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

extern NSString * const kRPGQuestListResponseStatus;
extern NSString * const kRPGQuestListResponseQuests;

@interface RPGQuestListResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, retain, readonly) NSArray<RPGQuest *> *quests;

- (instancetype)initWithStatus:(NSInteger)aStatus
                        quests:(NSArray<RPGQuest *> *)aQuests NS_DESIGNATED_INITIALIZER;
+ (instancetype)responseWithStatus:(NSInteger)aStatus
                            quests:(NSArray<RPGQuest *> *)aQuests;

@end
