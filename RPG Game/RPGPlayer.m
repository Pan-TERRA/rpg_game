//
//  RPGPlayer.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer.h"
#import "NSUserDefaults+RPGSessionInfo.h"

NSString * const kRPGPlayerSkills = @"skills";

@interface RPGPlayer ()

@end

@implementation RPGPlayer

@synthesize skills = _skills;

#pragma mark - Init

- (instancetype)initWithSkills:(NSArray<NSNumber *> *)aSkills
{
  self = [super initWithName:[NSUserDefaults standardUserDefaults].sessionUsername HP:100];
  
  if (self != nil)
  {
    NSMutableArray *skillsArray = [NSMutableArray array];
    for (NSNumber *skillID in aSkills)
    {
      [skillsArray addObject:[NSDictionary dictionaryWithObject:@(0) forKey:skillID]];
    }
    _skills = [skillsArray retain];
  }
  
  return self;
}

+ (instancetype)playerWithSkills:(NSArray<NSNumber *> *)aSkills
{
  return [[[self alloc] initWithSkills:aSkills] autorelease];
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
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  dictionaryRepresentation[kRPGPlayerSkills] = self.skills;
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  self = [super initWithDictionaryRepresentation:aDictionary];
  self.skills = aDictionary[kRPGPlayerSkills];
  return self;
}
@end
