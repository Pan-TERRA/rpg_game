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

NSString * const kRPGPlayerSkills = @"skills";
NSString * const kRPGPlayerCurrentWinCount = @"current_win_count";

@interface RPGPlayer ()

@end

@implementation RPGPlayer

@synthesize skills = _skills;

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
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  dictionaryRepresentation[kRPGPlayerSkills] = self.skills;
  dictionaryRepresentation[kRPGPlayerCurrentWinCount] = @(self.currentWinCount);
  
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
                     skills:aDictionary[kRPGPlayerSkills]
            currentWinCount:[aDictionary[kRPGPlayerCurrentWinCount] integerValue]];
}

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
