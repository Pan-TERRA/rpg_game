//
//  RPGBattleConditionResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"

NSString * const kRPGBattleConditionResponseType = @"BATTLE_CONDITION";

@interface RPGBattleConditionResponse ()

@property (nonatomic, assign, readwrite) NSInteger HP;
@property (nonatomic, assign, readwrite) NSInteger opponentHP;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableSkillsCondition;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableSkillsDamage;
@property (nonatomic, retain, readwrite) NSMutableDictionary *mutableReward;

@end

@implementation RPGBattleConditionResponse

#pragma mark - Init

- (instancetype)initWithHP:(NSInteger)aHP
                opponentHP:(NSInteger)anOpponentHP
           skillsCondition:(NSArray *)aSkillsCondition
              skillsDamage:(NSArray *)aSkillsDamage
                    reward:(NSDictionary *)aReward
                    status:(NSInteger)aStatus
{
  self = [super initWithType:kRPGBattleConditionResponseType
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
                   status:-1];
}

+ (instancetype)battleConditionResponseWithHP:(NSInteger)aHP
                                   opponentHP:(NSInteger)anOpponentHP
                              skillsCondition:(NSArray *)aSkillsCondition
                                 skillsDamage:(NSArray *)aSkillsDamage
                                       reward:(NSDictionary *)aReward
                                       status:(NSInteger)aStatus
{
  return [[[self alloc] initWithHP:aHP
                        opponentHP:anOpponentHP
                   skillsCondition:aSkillsCondition
                      skillsDamage:aSkillsDamage
                            reward:aReward
                            status:aStatus] autorelease];
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

@end
