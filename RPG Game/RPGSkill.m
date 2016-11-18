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
{
  self = [super init];
  if (self != nil)
  {
    _skillID = aSkillID;
    _cooldown = 0;
  }
  return self;
}

+ (instancetype)skillWithSkillID:(NSInteger)aSkillID
{
  return [[[RPGSkill alloc] initWithSkillID:aSkillID] autorelease];
}

- (instancetype)initWithSkillID:(NSInteger)aSkillID cooldown:(NSInteger)aCooldown
{
  self = [self initWithSkillID:aSkillID];
  if (self != nil)
  {
    _cooldown = aCooldown;
  }
  return self;
}

+ (instancetype)skillWithSkillID:(NSInteger)aSkillID cooldown:(NSInteger)aCooldown;
{
  return [[[RPGSkill alloc] initWithSkillID:aSkillID cooldown:aCooldown] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

@end
