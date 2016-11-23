//
//  RPGArenaSkillsResponse.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaSkillsResponse.h"

static NSString * const kRPGArenaSkillsResponseStatus = @"status";
static NSString * const kRPGArenaSkillsResponseSkills = @"skills";

@implementation RPGArenaSkillsResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)status skills:(NSArray *)skills
{
  self = [super init];
  
  if (self != nil)
  {
    if (status != -1 && skills != nil)
    {
      _status = status;
      _skills = [skills retain];
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithStatus:-1 skills:nil];
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
  
  dictionary[kRPGArenaSkillsResponseStatus] = @(self.status);
  dictionary[kRPGArenaSkillsResponseSkills] = self.skills;
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGArenaSkillsResponseStatus] integerValue]
                       skills:aDictionary[kRPGArenaSkillsResponseSkills]];
}

@end
