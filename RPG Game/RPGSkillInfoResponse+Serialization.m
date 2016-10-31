//
//  RPGSkillInfoResponse+Serialization.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillInfoResponse+Serialization.h"

static NSString * const kRPGSkillInfoResponseStatus = @"status";
static NSString * const kRPGSkillInfoResponseSkill = @"skill";

@implementation RPGSkillInfoResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  return @{
           kRPGSkillInfoResponseStatus: @(self.status),
           kRPGSkillInfoResponseSkill: self.skill
          };
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGSkillInfoResponseStatus] integerValue]
                        skill:aDictionary[kRPGSkillInfoResponseSkill]];
}

@end
