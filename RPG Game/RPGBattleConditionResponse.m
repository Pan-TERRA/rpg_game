//
//  RPGBattleConditionResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"
#import "RPGMessageTypes.h"

NSString * const kRPGBattleConditionResponseHP = @"hp";
NSString * const kRPGBattleConditionResponseOpponentHP = @"opponent_hp";
NSString * const kRPGBattleConditionResponseSkillsCondition = @"skills_condition";
NSString * const kRPGBattleConditionResponseSkillsDamage = @"skills_damage";
NSString * const kRPGBattleConditionResponseReward = @"reward";
NSString * const kRPGBattleConditionResponseStatus = @"status";
NSString * const kRPGBattleConditionResponseCurrentTurn = @"is_current_turn";

@interface RPGBattleConditionResponse ()

@property (nonatomic, assign, readwrite) NSInteger HP;
@property (nonatomic, assign, readwrite) NSInteger opponentHP;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableSkillsCondition;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableSkillsDamage;
@property (nonatomic, retain, readwrite) NSMutableDictionary *mutableReward;
@property (nonatomic, assign, readwrite, getter=isCurrentTurn) BOOL currentTurn;

@end

@implementation RPGBattleConditionResponse

#pragma mark - Init

- (instancetype)initWithHP:(NSInteger)aHP
                opponentHP:(NSInteger)anOpponentHP
           skillsCondition:(NSArray *)aSkillsCondition
              skillsDamage:(NSArray *)aSkillsDamage
                    reward:(NSDictionary *)aReward
                    status:(NSInteger)aStatus
               currentTurn:(BOOL)aCurrentTurn
{
  self = [super initWithType:kRPGBattleConditionMessageType
                      status:aStatus];
  
  if (self != nil)
  {
    if (aHP < 0 ||
        anOpponentHP < 0 ||
        aSkillsCondition == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _HP = aHP;
      _opponentHP = anOpponentHP;
      _mutableSkillsCondition = [aSkillsCondition mutableCopy];
      _mutableSkillsDamage = [aSkillsDamage mutableCopy];
      _mutableReward = [aReward mutableCopy];
      _currentTurn = aCurrentTurn;
    }
  }
  
  return self;
}

- (instancetype)initWithType:(NSString *)aType
                      status:(NSInteger)aStatus
{
  return [self initWithHP:-1
               opponentHP:-1
          skillsCondition:nil
             skillsDamage:nil
                   reward:nil
                   status:-1
              currentTurn:NO];
}

+ (instancetype)battleConditionResponseWithHP:(NSInteger)aHP
                                   opponentHP:(NSInteger)anOpponentHP
                              skillsCondition:(NSArray *)aSkillsCondition
                                 skillsDamage:(NSArray *)aSkillsDamage
                                       reward:(NSDictionary *)aReward
                                       status:(NSInteger)aStatus
                                  currentTurn:(BOOL)aCurrentTurn
{
  return [[[self alloc] initWithHP:aHP
                        opponentHP:anOpponentHP
                   skillsCondition:aSkillsCondition
                      skillsDamage:aSkillsDamage
                            reward:aReward
                            status:aStatus
                       currentTurn:aCurrentTurn] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_mutableSkillsCondition release];
  [_mutableSkillsDamage release];
  [_mutableReward release];
  
  [super dealloc];
}

#pragma mark - Accessors

- (NSArray *)skillsCondition
{
  return self.mutableSkillsCondition;
}

- (NSArray *)skillsDamage
{
  return self.mutableSkillsDamage;
}

- (NSDictionary *)reward
{
  return self.mutableReward;
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  dictionaryRepresentation[kRPGBattleConditionResponseHP] = @(self.HP);
  dictionaryRepresentation[kRPGBattleConditionResponseOpponentHP] = @(self.opponentHP);
  dictionaryRepresentation[kRPGBattleConditionResponseSkillsCondition] = self.skillsCondition;
  dictionaryRepresentation[kRPGBattleConditionResponseSkillsDamage] = self.skillsDamage;
  dictionaryRepresentation[kRPGBattleConditionResponseReward] = self.reward;
  dictionaryRepresentation[kRPGBattleConditionResponseStatus] = @(self.status);
  dictionaryRepresentation[kRPGBattleConditionResponseCurrentTurn] = @(self.currentTurn);
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithHP:[aDictionary[kRPGBattleConditionResponseHP] integerValue]
               opponentHP:[aDictionary[kRPGBattleConditionResponseOpponentHP] integerValue]
          skillsCondition:aDictionary[kRPGBattleConditionResponseSkillsCondition]
             skillsDamage:aDictionary[kRPGBattleConditionResponseSkillsDamage]
                   reward:aDictionary[kRPGBattleConditionResponseReward]
                   status:[aDictionary[kRPGBattleConditionResponseStatus] integerValue]
              currentTurn:[aDictionary[kRPGBattleConditionResponseCurrentTurn] boolValue]];
}

@end
