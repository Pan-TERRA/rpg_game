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
    if (status >= 0 && skills != nil)
    {
      _status = status;
      _skills = [[NSArray alloc] initWithArray:skills];
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

@end
