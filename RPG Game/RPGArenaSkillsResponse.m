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

- (instancetype)initWithStatus:(NSInteger)aStatus skills:(NSArray *)aSkills
{
  self = [super init];
  
  if (self != nil)
  {
    if (aStatus != -1 && aSkills != nil)
    {
      _status = aStatus;
      _skills = [aSkills retain];
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
