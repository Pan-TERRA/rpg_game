//
//  RPGSkillActionRequest+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillActionRequest+Serialization.h"
#import "RPGRequest+Serialization.h"
#import "RPGSkill+Serialization.h"

@implementation RPGSkillActionRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  // !!!: change to proper constant
//  dictionaryRepresentation[kRPGSkillID] = @(self.skillID);
    dictionaryRepresentation[@"skill_id"] = @(self.skillID);
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSInteger skillID = [aDictionary[kRPGSkillID] integerValue];
  return [self initWithSkillID:skillID token:aDictionary[kRPGRequestSerializationToken]];
}


@end
