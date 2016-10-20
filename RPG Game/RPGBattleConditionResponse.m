//
//  RPGBattleConditionResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"

static NSString * const kRPGBattleConditionResponseType = @"BATTLE_CONDITION";

@interface RPGBattleConditionResponse ()

@property (nonatomic, assign, readwrite) NSInteger HP;
@property (nonatomic, assign, readwrite) NSInteger opponentHP;
@property (nonatomic, retain, readwrite) NSMutableDictionary *mutableSpellsCondition;
@property (nonatomic, retain, readwrite) NSMutableDictionary *mutableReward;

@end

@implementation RPGBattleConditionResponse

#pragma mark - Init

- (instancetype)initWithHP:(NSInteger)aHP
                opponentHP:(NSInteger)anOpponentHP
           spellsCondition:(NSDictionary *)aSpellsCondition
                    reward:(NSDictionary *)aReward
                    status:(NSInteger)aStatus
{
  self = [super initWithType:kRPGBattleConditionResponseType
                      status:aStatus];
  
  if (self != nil)
  {
    if (aHP < 0 ||
        anOpponentHP < 0 ||
        aSpellsCondition == nil ||
        aReward == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _HP = aHP;
      _opponentHP = anOpponentHP;
      _spellsCondition = [aSpellsCondition mutableCopy];
      _reward = [aReward mutableCopy];
    }
  }
  
  return self;
}

- (instancetype)initWithType:(NSString *)aType
                      status:(NSInteger)aStatus
{
  return [self initWithHP:-1
               opponentHP:-1
          spellsCondition:nil
                   reward:nil
                   status:-1];
}

+ (instancetype)battleConditionResponseWithHP:(NSInteger)aHP
                                   opponentHP:(NSInteger)anOpponentHP
                              spellsCondition:(NSDictionary *)aSpellsCondition
                                       reward:(NSDictionary *)aReward
                                       status:(NSInteger)aStatus
{
  return [[[RPGBattleConditionResponse alloc] initWithHP:aHP
                                              opponentHP:anOpponentHP
                                         spellsCondition:aSpellsCondition
                                                  reward:aReward
                                                  status:aStatus] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_mutableSpellsCondition release];
  [_mutableReward release];
  [super dealloc];
}

@end