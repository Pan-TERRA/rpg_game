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

@property (nonatomic, readwrite) int HP;
@property (nonatomic, readwrite) int opponentHP;
@property (retain, nonatomic) NSMutableDictionary *mutableSpellsCondition;
@property (retain, nonatomic, readonly) NSMutableDictionary *mutableReward;

@end

@implementation RPGBattleConditionResponse

@synthesize HP = _HP;
@synthesize opponentHP = _opponentHP;
@synthesize mutableSpellsCondition = _mutableSpellsCondition;
@synthesize mutableReward = _mutableReward;

#pragma mark - Init

- (instancetype)initWithHP:(int)aHP
                opponentHP:(int)anOpponentHP
           spellsCondition:(NSDictionary *)aSpellsCondition
                    reward:(NSDictionary *)aReward
                    status:(NSInteger)aStatus
{
  self = [super initWithType:kRPGBattleConditionResponseType status:aStatus];
  
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

- (instancetype)initWithType:(NSString *)aType status:(NSInteger)aStatus
{
  return [self initWithHP:-1 opponentHP:-1 spellsCondition:nil reward:nil status:-1];
}

+ (instancetype)battleConditionResponseWithHP:(int)aHP
                                   opponentHP:(int)anOpponentHP
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

- (void)dealloc
{
  [_mutableSpellsCondition release];
  [_mutableReward release];
  
  [super dealloc];
}
@end
