//
//  RPGQuest+Serialization.h
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuest.h"

extern NSString * const kRPGQuestID;
extern NSString * const kRPGQuestName;
extern NSString * const kRPGQuestDescription;
extern NSString * const kRPGQuestState;
extern NSString * const kRPGQuestReward;

@interface RPGQuest (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end