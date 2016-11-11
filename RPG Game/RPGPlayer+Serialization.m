//
//  RPGPlayer+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer+Serialization.h"
#import "RPGEntity+Serialization.h"
#import "RPGSkill+Serialization.h"

NSString * const kRPGPlayerSkills = @"skills";

@implementation RPGPlayer (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  NSMutableArray *skills = [NSMutableArray arrayWithCapacity:[self.skills count]];
  for (RPGSkill *skill in self.skills)
  {
    [skills addObject:[skill dictionaryRepresentation]];
  }
  dictionaryRepresentation[kRPGEntityName] = skills;
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSMutableArray *skills = [NSMutableArray array];
  
  for (NSDictionary *skillDictionaryRepresentation in aDictionary[kRPGPlayerSkills])
  {
    RPGSkill *skill = [[RPGSkill alloc] initWithDictionaryRepresentation:skillDictionaryRepresentation];
    [skills addObject:skill];
    [skill release];
  }
  
  return [self initWithSkills:skills];
}


@end
