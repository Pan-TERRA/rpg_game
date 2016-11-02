//
//  RPGSkill.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkill.h"

@interface RPGSkill ()

@property (assign, nonatomic, readwrite) NSInteger skillID;

@end

@implementation RPGSkill

#pragma mark - Init

- (instancetype)initWithSkillID:(NSInteger)aSkillID
{
  self = [super init];
  
  if (self != nil)
  {
    _skillID = aSkillID;
  }
  
  return self;
}

+ (instancetype)skillWithSkillID:(NSInteger)aSkillID
{
  return [[[self alloc] initWithSkillID:aSkillID] autorelease];
}


@end
