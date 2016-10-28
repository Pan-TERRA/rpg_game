//
//  RPGSkillsResponse+Serialization.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsResponse+Serialization.h"

static NSString * const kRPGSkillsResposeStatus = @"status";
static NSString * const kRPGSkillsResposeSkills = @"skills";

@implementation RPGSkillsResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  dictionary[kRPGSkillsResposeStatus] = @(self.status);
  dictionary[kRPGSkillsResposeSkills] = self.skills;
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGSkillsResposeStatus] integerValue]
                       skills:aDictionary[kRPGSkillsResposeSkills]];
}

@end
