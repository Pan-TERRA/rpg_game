//
//  RPGCharacterProfileInfoResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterProfileInfoResponse.h"
#import "RPGCharacterProfileSkill.h"

NSString * const kRPGCharacterProfileInfoResponseStatus = @"status";
NSString * const kRPGCharacterProfileInfoResponseCurrentLevel = @"current_level";
NSString * const kRPGCharacterProfileInfoResponseMaxExp = @"max_exp";
NSString * const kRPGCharacterProfileInfoResponseCurrentExp = @"current_exp";
NSString * const kRPGCharacterProfileInfoResponseAttack = @"attack";
NSString * const kRPGCharacterProfileInfoResponseHP = @"hp";
NSString * const kRPGCharacterProfileInfoResponseBagSize = @"bag_size";
NSString * const kRPGCharacterProfileInfoResponseActiveSkillsBagSize = @"active_skills_bag_size";
NSString * const kRPGCharacterProfileInfoResponseSkills = @"skills";

@interface RPGCharacterProfileInfoResponse()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, assign, readwrite) NSUInteger currentLevel;
@property (nonatomic, assign, readwrite) NSUInteger maxExp;
@property (nonatomic, assign, readwrite) NSUInteger currentExp;
@property (nonatomic, assign, readwrite) NSUInteger attack;
@property (nonatomic, assign, readwrite) NSUInteger hp;
@property (nonatomic, assign, readwrite) NSUInteger bagSize;
@property (nonatomic, assign, readwrite) NSUInteger activeSkillsBagSize;
@property (nonatomic, retain, readwrite) NSArray *skills;

@end

@implementation RPGCharacterProfileInfoResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
                  currentLevel:(NSUInteger)aCurrentLevel
                        maxExp:(NSUInteger)aMaxExp
                    currentExp:(NSUInteger)aCurrentExp
                        attack:(NSUInteger)anAttack
                            HP:(NSUInteger)aHP
                       bagSize:(NSUInteger)aBagSize
           activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                        skills:(NSArray *)aSkills
{
  self = [super init];
  
  if (self != nil)
  {
    _status = aStatus;
    _currentLevel = aCurrentLevel;
    _maxExp = aMaxExp;
    _currentExp = aCurrentExp;
    _attack = anAttack;
    _HP = aHP;
    _bagSize = aBagSize;
    _activeSkillsBagSize = anActiveSkillsBagSize;
    _skills = [aSkills retain];
  }
  
  return self;
}

+ (instancetype)characterProfileInfoResponseWithStatus:(NSInteger)aStatus
                                          currentLevel:(NSUInteger)aCurrentLevel
                                                maxExp:(NSUInteger)aMaxExp
                                            currentExp:(NSUInteger)aCurrentExp
                                                attack:(NSUInteger)anAttack
                                                    HP:(NSUInteger)aHP
                                               bagSize:(NSUInteger)aBagSize
                                   activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                                                skills:(NSArray *)aSkills
{
  return [[[self alloc] initWithStatus:aStatus
                          currentLevel:aCurrentLevel
                                maxExp:aMaxExp
                            currentExp:aCurrentExp
                                attack:anAttack
                                    HP:aHP
                               bagSize:aBagSize
                   activeSkillsBagSize:anActiveSkillsBagSize
                                skills:aSkills] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:0
                 currentLevel:0
                       maxExp:0
                   currentExp:0
                       attack:0
                           HP:0
                      bagSize:0
          activeSkillsBagSize:0
                       skills:nil];
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
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseStatus] = @(self.status);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseCurrentLevel] = @(self.currentLevel);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseMaxExp] = @(self.maxExp);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseCurrentExp] = @(self.currentExp);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseAttack] = @(self.attack);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseHP] = @(self.HP);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseBagSize] = @(self.bagSize);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseActiveSkillsBagSize] = @(self.activeSkillsBagSize);
  if (self.skills)
  {
    NSMutableArray *skillsMutableArray = [NSMutableArray array];
    for (RPGCharacterProfileSkill *skill in self.skills)
    {
      [skillsMutableArray addObject:[skill dictionaryRepresentation]];
    }
    dictionaryRepresentation[kRPGCharacterProfileInfoResponseSkills] = skillsMutableArray;
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSArray *skillsDictionaryArray = aDictionary[kRPGCharacterProfileInfoResponseSkills];
  NSMutableArray *skills  =[NSMutableArray array];
  
  for (NSDictionary *skillDictionary in skillsDictionaryArray)
  {
    RPGCharacterProfileSkill *skill = [[[RPGCharacterProfileSkill alloc] initWithDictionaryRepresentation:skillDictionary] autorelease];
    [skills addObject:skill];
  }
  
  return [self initWithStatus:[aDictionary[kRPGCharacterProfileInfoResponseStatus] integerValue]
                 currentLevel:[aDictionary[kRPGCharacterProfileInfoResponseCurrentLevel] integerValue]
                       maxExp:[aDictionary[kRPGCharacterProfileInfoResponseMaxExp] integerValue]
                   currentExp:[aDictionary[kRPGCharacterProfileInfoResponseCurrentExp] integerValue]
                       attack:[aDictionary[kRPGCharacterProfileInfoResponseAttack] integerValue]
                           HP:[aDictionary[kRPGCharacterProfileInfoResponseHP] integerValue]
                      bagSize:[aDictionary[kRPGCharacterProfileInfoResponseBagSize] integerValue]
          activeSkillsBagSize:[aDictionary[kRPGCharacterProfileInfoResponseActiveSkillsBagSize] integerValue]
                       skills:skills];
}

@end
