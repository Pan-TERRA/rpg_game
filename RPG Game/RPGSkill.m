//
//  RPGSkill.m
//  RPG Game
//
//  Created by Владислав Крут on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkill.h"

@implementation RPGSkill

#pragma mark - Init

- (instancetype)initWithSkillID:(NSInteger)aSkillID
                       cooldown:(NSInteger)aCooldown
{
  self = [super init];
  
  if (self != nil)
  {
    if (aSkillID < 1)
    {
      [self release];
      self = nil;
    }
    else
    {
      _skillID = aSkillID;
      _cooldown = 0;
    }
  }
  
  return self;
}

+ (instancetype)skillWithSkillID:(NSInteger)aSkillID
                        cooldown:(NSInteger)aCooldown;
{
  return [[[RPGSkill alloc] initWithSkillID:aSkillID
                                   cooldown:aCooldown] autorelease];
}

- (instancetype)initWithSkillID:(NSInteger)aSkillID
{
  return [self initWithSkillID:aSkillID
                      cooldown:0];
}

+ (instancetype)skillWithSkillID:(NSInteger)aSkillID
{
  return [[[RPGSkill alloc] initWithSkillID:aSkillID
                                   cooldown:0] autorelease];
}

- (instancetype)init
{
  return [self initWithSkillID:-1
                      cooldown:-1];
}

#pragma mark - Description

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ r\n %ld \r\n %ld", [super description], (long)self.skillID, (long)self.cooldown];
}

@end
