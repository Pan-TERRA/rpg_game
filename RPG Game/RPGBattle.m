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
#import "RPGResources.h"
#import "RPGBattleLog.h"

const NSInteger kRPGBattleTurnDuration = 30;

@interface RPGBattle ()

@property (assign, nonatomic, readwrite, getter=isCurrentTurn) BOOL currentTurn;
@property (retain, nonatomic, readwrite) RPGResources *reward;
@property (retain, nonatomic, readwrite) RPGBattleLog *battleLog;

@end

@implementation RPGBattle

#pragma mark - Init

- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  self = [super init];
  
  if (self != nil)
  {
//    _player = nil;
    _opponent = [aResponse.opponentInfo retain];
    _startTime = aResponse.time;
    _currentTime = aResponse.time;
    _currentTurn = aResponse.currentTurn;
    _reward = [[RPGResources alloc] init];
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
  
  RPGResources *reward = aResponse.reward;
  if (reward != nil)
  {
    self.reward = reward;
  }
  
   //update player.skills array with new colldowns
  NSMutableArray *newSkills = [NSMutableArray array];
  for (NSDictionary *dictionary in aResponse.skillsCondition)
  {
    NSInteger skillID = [dictionary[@"skill_id"] integerValue];
    NSInteger skillCooldown = [dictionary[@"cooldown"] integerValue];
    RPGSkill *skill = [RPGSkill skillWithSkillID:skillID cooldown:skillCooldown];
    [newSkills addObject:skill];
  }
  self.player.skills = newSkills;
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

@end
