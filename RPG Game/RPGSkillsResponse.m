//
//  RPGSkillsResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsResponse.h"

static NSString * const kRPGSkillsResposeStatus = @"status";
static NSString * const kRPGSkillsResposeSkills = @"skills";

@implementation RPGSkillsResponse

#pragma mark - Init

- (instancetype)init
{
  return [self initWithStatus:-1 skills:nil];
}

- (instancetype)initWithStatus:(NSInteger)status skills:(NSArray *)skills
{
  self = [super init];
  if (self != nil)
  {
    _status = status;
    if (skills != nil)
    {
      _skills = [[NSArray alloc] initWithArray:skills];
    }
    else
    {
      _skills = [[NSArray alloc] init];
    }
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skills release];
  [super dealloc];
}

#pragma mark - RPGSerializable

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
