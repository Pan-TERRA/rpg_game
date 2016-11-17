//
//  RPGCharacterProfileInfoResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterProfileInfoResponse.h"
#import "RPGSkill.h"

NSString * const kRPGCharacterProfileInfoResponseStatus = @"status";
NSString * const kRPGCharacterProfileInfoResponseAvatar = @"avatar";
NSString * const kRPGCharacterProfileInfoResponseCurrentLevel = @"current_level";
NSString * const kRPGCharacterProfileInfoResponseMaxExp = @"max_exp";
NSString * const kRPGCharacterProfileInfoResponseCurrentExp = @"current_exp";
NSString * const kRPGCharacterProfileInfoResponseAttack = @"attack";
NSString * const kRPGCharacterProfileInfoResponseHp = @"hp";
NSString * const kRPGCharacterProfileInfoResponseBagSize = @"bag_size";
NSString * const kRPGCharacterProfileInfoResponseActiveSkillsBagSize = @"active_skills_bag_size";
NSString * const kRPGCharacterProfileInfoResponseSkills = @"skills";

@interface RPGCharacterProfileInfoResponse()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, copy, readwrite) NSString *avatar;
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
                        avatar:(NSString *)anAvatar
                  currentLevel:(NSUInteger)aCurrentLevel
                        maxExp:(NSUInteger)aMaxExp
                    currentExp:(NSUInteger)aCurrentExp
                        attack:(NSUInteger)anAttack
                            hp:(NSUInteger)aHp
                       bagSize:(NSUInteger)aBagSize
           activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                        skills:(NSArray *)aSkills
{
  return self;
}

+ (instancetype)characterProfileInfoResponseWithStatus:(NSInteger)aStatus
                                                avatar:(NSString *)anAvatar
                                          currentLevel:(NSUInteger)aCurrentLevel
                                                maxExp:(NSUInteger)aMaxExp
                                            currentExp:(NSUInteger)aCurrentExp
                                                attack:(NSUInteger)anAttack
                                                    hp:(NSUInteger)aHp
                                               bagSize:(NSUInteger)aBagSize
                                   activeSkillsBagSize:(NSUInteger)anActiveSkillsBagSize
                                                skills:(NSArray *)aSkills
{
  return [[[self alloc] initWithStatus:aStatus
                                avatar:anAvatar
                          currentLevel:aCurrentLevel
                                maxExp:aMaxExp
                            currentExp:aCurrentExp
                                attack:anAttack
                                    hp:aHp
                               bagSize:aBagSize
                   activeSkillsBagSize:anActiveSkillsBagSize
                                skills:aSkills] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:0
                       avatar:nil
                 currentLevel:0
                       maxExp:0
                   currentExp:0
                       attack:0
                           hp:0
                      bagSize:0
          activeSkillsBagSize:0
                       skills:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_avatar release];
  [_skills release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseStatus] = @(self.status);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseAvatar] = self.avatar;
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseCurrentLevel] = @(self.currentLevel);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseMaxExp] = @(self.maxExp);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseCurrentExp] = @(self.currentExp);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseAttack] = @(self.attack);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseHp] = @(self.hp);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseBagSize] = @(self.bagSize);
  dictionaryRepresentation[kRPGCharacterProfileInfoResponseActiveSkillsBagSize] = @(self.activeSkillsBagSize);
  if (self.skills)
  {
    NSMutableArray *skillsMutableArray = [NSMutableArray array];
    for (RPGSkill *skill in self.skills)
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
    RPGSkill *skill = [[[RPGSkill alloc] initWithDictionaryRepresentation:skillDictionary] autorelease];
    [skills addObject:skill];
  }
  return [self initWithStatus:[aDictionary[kRPGCharacterProfileInfoResponseStatus] integerValue]
                       avatar:aDictionary[kRPGCharacterProfileInfoResponseAvatar]
                 currentLevel:[aDictionary[kRPGCharacterProfileInfoResponseCurrentLevel] integerValue]
                       maxExp:[aDictionary[kRPGCharacterProfileInfoResponseMaxExp] integerValue]
                   currentExp:[aDictionary[kRPGCharacterProfileInfoResponseCurrentExp] integerValue]
                       attack:[aDictionary[kRPGCharacterProfileInfoResponseAttack] integerValue]
                           hp:[aDictionary[kRPGCharacterProfileInfoResponseHp] integerValue]
                      bagSize:[aDictionary[kRPGCharacterProfileInfoResponseBagSize] integerValue]
          activeSkillsBagSize:[aDictionary[kRPGCharacterProfileInfoResponseActiveSkillsBagSize] integerValue]
                       skills:skills];
}

@end
