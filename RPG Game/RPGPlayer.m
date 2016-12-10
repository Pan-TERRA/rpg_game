//
//  RPGPlayer.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer.h"
  // Entities
#import "RPGSkill.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"

NSString * const kRPGPlayerSkills = @"skills";
NSString * const kRPGPlayerCurrentWinCount = @"win_count";

@implementation RPGPlayer

#pragma mark - Init

- (instancetype)initWithName:(NSString *)aName
                          HP:(NSInteger)aHP
                       maxHP:(NSInteger)aMaxHP
                       level:(NSInteger)aLevel
                      skills:(NSArray<RPGSkill *> *)aSkills
             currentWinCount:(NSInteger)aCurrentWinCount;
{
  self = [super initWithName:aName
                          HP:aHP
                       maxHP:aMaxHP
                       level:aLevel];
  
  if (self != nil)
  {
    _skills = [aSkills retain];
    _currentWinCount = aCurrentWinCount;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithName:nil
                         HP:-1
                      maxHP:-1
                      level:-1
                     skills:nil
            currentWinCount:-1];
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
                     skills:nil
            currentWinCount:-1];
}

+ (instancetype)playerWithName:(NSString *)aName
                            HP:(NSInteger)aHP
                         maxHP:(NSInteger)aMaxHP
                         level:(NSInteger)aLevel
                        skills:(NSArray<RPGSkill *> *)aSkills
               currentWinCount:(NSInteger)aCurrentWinCount;
{
  return [[[self alloc] initWithName:aName
                                  HP:aHP
                               maxHP:aMaxHP
                               level:aLevel
                              skills:aSkills
                     currentWinCount:aCurrentWinCount] autorelease];
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
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  if (self.skills)
  {
    dictionaryRepresentation[kRPGPlayerSkills] = self.skills;
  }
  if (self.currentWinCount != -1)
  {
    dictionaryRepresentation[kRPGPlayerCurrentWinCount] = @(self.currentWinCount);
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
    // TODO: redo, choose in characters profile
  NSString *charNickName = [NSUserDefaults standardUserDefaults].characterNickName;
  NSNumber *currentWinCountObject = aDictionary[kRPGPlayerCurrentWinCount];
  NSInteger currentWinCount = (currentWinCountObject != nil ? [currentWinCountObject integerValue] : -1);
  
  return [self initWithName:charNickName
                         HP:[aDictionary[kRPGEntityHP] integerValue]
                      maxHP:[aDictionary[kRPGEntityMaxHP] integerValue]
                      level:[aDictionary[kRPGEntityLevel] integerValue]
                     skills:aDictionary[kRPGPlayerSkills]
            currentWinCount:currentWinCount];
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
