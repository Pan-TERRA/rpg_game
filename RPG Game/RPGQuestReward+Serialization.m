//
//  RPGQuestReward+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReward+Serialization.h"
#import "RPGResources+Serialization.h"

NSString * const kRPGQuestRewardSkillId = @"skill_id";

@implementation RPGQuestReward (Serialization)

- (NSDictionary *)dictionaryRepresentation
{  
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGQuestRewardSkillId] = @(self.skillID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithGold:[aDictionary[kRPGResourcesGold] integerValue]
                   crystals:[aDictionary[kRPGResourcesCrystals] integerValue]
                    skillID:[aDictionary[kRPGQuestRewardSkillId] integerValue]];
}

@end
