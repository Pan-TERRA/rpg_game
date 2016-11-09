//
//  RPGBattle.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattle.h"
  // Entities
#import "RPGBattleConditionResponse.h"
#import "RPGTimeResponse.h"
#import "RPGBattleInitResponse+Serialization.h"
#import "RPGPlayer.h"
#import "RPGSFXEngine.h"
#import "RPGResources.h"

const NSInteger kRPGBattleTurnDuration = 30;

@interface RPGBattle ()

@property (assign, nonatomic, readwrite, getter=isCurrentTurn) BOOL currentTurn;
@property (retain, nonatomic, readwrite) RPGResources *reward;

@end

@implementation RPGBattle

#pragma mark - Init

- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  self = [super init];
  
  if (self != nil)
  {
    _opponent = [aResponse.opponentInfo retain];
    _startTime = aResponse.time;
    _currentTime = aResponse.time;
    _currentTurn = aResponse.currentTurn;
    _reward = [[RPGResources alloc] init];
  }
  
  return self;
}

+ (instancetype)battleWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  return [[[self alloc] initWithBattleInitResponse:aResponse] autorelease];
}

- (void)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse
{
  self.player.HP = aResponse.HP;
  self.opponent.HP = aResponse.opponentHP;
  self.currentTurn = aResponse.currentTurn;
  
  RPGResources *reward = aResponse.reward;
  if (reward != nil)
  {
    self.reward = reward;
  }
  
  //TODO: remove hardcode && remove SFXEngine logic from model
  NSInteger skillID = [[aResponse.skillsDamage valueForKey:@"skill_id"] integerValue];
  
  if (skillID != 0)
  {
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:skillID];
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
  
  [super dealloc];
}

@end
