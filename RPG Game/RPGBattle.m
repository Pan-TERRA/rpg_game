//
//  RPGBattle.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattle.h"
  // Entities
#import "RPGPlayer.h"
#import "RPGBattleConditionResponse.h"
#import "RPGTimeResponse.h"
#import "RPGBattleInitResponse.h"
#import "RPGSkill.h"
#import "RPGSFXEngine.h"
#import "RPGBattleReward.h"
#import "RPGBattleLog.h"

const NSInteger kRPGBattleTurnDuration = 30;

@interface RPGBattle ()

@property (assign, nonatomic, readwrite, getter=isCurrentTurn) BOOL currentTurn;
@property (retain, nonatomic, readwrite) RPGBattleReward *reward;
@property (retain, nonatomic, readwrite) RPGBattleLog *battleLog;
@property (assign, nonatomic, readwrite) RPGBattleStatus battleStatus;

@end

@implementation RPGBattle

#pragma mark - Init

- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  self = [super init];
  
  if (self != nil)
  {
    _battleStatus = kRPGBattleStatusBattleInProgress;
    _player = [aResponse.playerInfo retain];
    _opponent = [aResponse.opponentInfo retain];
    _startTime = aResponse.time;
    _currentTime = aResponse.time;
    _currentTurn = aResponse.currentTurn;
    _reward = [[RPGBattleReward alloc] init];
    _battleLog = [[RPGBattleLog alloc] init];
  }
  
  return self;
}

+ (instancetype)battleWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  return [[[self alloc] initWithBattleInitResponse:aResponse] autorelease];
}

- (void)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse
{
  [self.battleLog updateWithBattleConditionResponse:aResponse];
  
  self.player.HP = aResponse.HP;
  self.opponent.HP = aResponse.opponentHP;
  self.currentTurn = aResponse.currentTurn;
  self.battleStatus = aResponse.battleStatus;
  
  RPGBattleReward *reward = aResponse.reward;
  if (reward != nil)
  {
    self.reward = reward;
  }
  
  for (NSDictionary *dictionary in aResponse.skillsCondition)
  {
    NSInteger skillID = [dictionary[@"skill_id"] integerValue];
    NSInteger skillCooldown = [dictionary[@"cooldown"] integerValue];
    
    RPGSkill *presentSkill = [self.player skillByID:skillID];
    
    if (presentSkill != nil)
    {
      presentSkill.cooldown = skillCooldown;
    }
  }
}

- (void)updateWithTimeSynchResponse:(RPGTimeResponse *)aResponse
{
  return;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_player release];
  [_opponent release];
  [_reward release];
  [_battleLog release];
  
  [super dealloc];
}

#pragma mark - KVO

+ (NSSet *)keyPathsForValuesAffectingPlayerMasterProperty
{
  return [NSSet setWithObject:@"player.HP"];
}

+ (NSSet *)keyPathsForValuesAffectingOpponentMasterProperty
{
  return [NSSet setWithObject:@"opponent.HP"];
}
@end
