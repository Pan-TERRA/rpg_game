//
//  RPGPlayer.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer.h"
#import "NSUserDefaults+RPGSessionInfo.h"

@implementation RPGPlayer

@synthesize skills = _skills;

#pragma mark - Init

- (instancetype)initWithSkills:(NSArray *)aSkills
{
  self = [super initWithName:[[NSUserDefaults standardUserDefaults] sessionUsername] HP:100];
  
  if (self != nil)
  {
    _skills = [aSkills retain];
  }
  
  return self;
}

+ (instancetype)playerWithSkills:(NSArray *)aSkills
{
  return [[[self alloc] initWithSkills:aSkills] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skills release];
  
  [super dealloc];
}
@end
