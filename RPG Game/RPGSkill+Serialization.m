//
//  RPGSkill+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkill+Serialization.h"

//NSString * const kRPGSkillID = @"skill_id";
NSString * const kRPGSkillID = @"id";
NSString * const kRPGSkillCooldown = @"cooldown";

@implementation RPGSkill (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGSkillID] = @(self.skillID);
  dictionaryRepresentation[kRPGSkillCooldown] = @(self.cooldown);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithSkillID:[aDictionary[kRPGSkillID] integerValue]
                      cooldown:[aDictionary[kRPGSkillCooldown] integerValue]];
}


@end
