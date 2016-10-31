//
//  RPGQuestReward+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReward+Serialization.h"

NSString * const kRPGQuestRewardGold = @"gold";
NSString * const kRPGQuestRewardCrystals = @"crystals";
NSString * const kRPGQuestRewardSkillId = @"skill_id";

@implementation RPGQuestReward (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGQuestRewardGold] = @(self.gold);
  dictionaryRepresentation[kRPGQuestRewardCrystals] = @(self.crystals);
  dictionaryRepresentation[kRPGQuestRewardSkillId] = @(self.skillID);
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSUInteger gold = [aDictionary[kRPGQuestRewardGold] integerValue];
  NSUInteger crystals = [aDictionary[kRPGQuestRewardCrystals] integerValue];
  NSUInteger skillID = [aDictionary[kRPGQuestRewardSkillId] integerValue];
  
  return [self initWithGold:gold crystals:crystals skillID:skillID];
}

@end