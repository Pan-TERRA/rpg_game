//
//  RPGSkillsResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsResponse.h"

@implementation RPGSkillsResponse

- (instancetype)init
{
  return [self initWithStatus:-1 skills:nil];
}

- (instancetype)initWithStatus:(NSInteger)status skills:(NSArray *)skills
{
  self = [super init];
  if (self)
  {
    _status = status;
    _skills = [[NSArray alloc] initWithArray:skills];
  }
  
  return self;
}

- (void)dealloc
{
  [_skills release];
  [super dealloc];
}

@end
