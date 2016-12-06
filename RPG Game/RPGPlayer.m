//
//  RPGPlayer.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGSkill.h"

static NSString * const kRPGPlayerSkills = @"skills";

@implementation RPGPlayer

#pragma mark - Init

- (instancetype)initWithName:(NSString *)aName
                          HP:(NSInteger)aHP
                       maxHP:(NSInteger)aMaxHP
                       level:(NSInteger)aLevel
                      skills:(NSArray<RPGSkill *> *)aSkills
{
  self = [super initWithName:aName
                          HP:aHP
                       maxHP:aMaxHP
                       level:aLevel];
  
  if (self != nil)
  {
    _skills = [aSkills retain];
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithName:nil
                         HP:-1
                      maxHP:-1
                      level:-1
                     skills:nil];
}

- (instancetype)initWithName:(NSString *)aName
                          HP:(NSInteger)aHP
                       maxHP:(NSInteger)aMaxHP
                       level:(NSInteger)aLevel
{
  return [self initWithName:aName
                         HP:aHP
                      maxHP:aMaxHP
                      level:aLevel
                     skills:nil];
}

+ (instancetype)playerWithName:(NSString *)aName
                            HP:(NSInteger)aHP
                         maxHP:(NSInteger)aMaxHP
                         level:(NSInteger)aLevel
                        skills:(NSArray<RPGSkill *> *)aSkills
{
  return [[[self alloc] initWithName:aName
                                  HP:aHP
                               maxHP:aMaxHP
                               level:aLevel
                              skills:aSkills] autorelease];
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
  
  if (self.skills)
  {
    dictionaryRepresentation[kRPGPlayerSkills] = self.skills;
  }
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
    // TODO: redo, choose in characters profile
  NSString *charNickName = [NSUserDefaults standardUserDefaults].characterNickName;
  
  return [self initWithName:charNickName
                         HP:[aDictionary[kRPGEntityHP] integerValue]
                      maxHP:[aDictionary[kRPGEntityMaxHP] integerValue]
                      level:[aDictionary[kRPGEntityLevel] integerValue]
                     skills:aDictionary[kRPGPlayerSkills]];
}

#pragma mark - Heplful Method

- (RPGSkill *)skillByID:(NSInteger)anID
{
  RPGSkill *result = nil;
  
  for (RPGSkill *skill in self.skills)
  {
    if (anID == skill.skillID)
    {
      result = skill;
      break;
    }
  }
  
  return result;
}

@end
