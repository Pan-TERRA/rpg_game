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
#import "RPGSkill+Serialization.h"

@interface RPGBattle ()

@property (assign, nonatomic, readwrite, getter=isCurrentTurn) BOOL currentTurn;

@end

@implementation RPGBattle

#pragma mark - Init

- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  self = [super init];
  
  if (self != nil)
  {
    _player = [[RPGPlayer alloc] initWithSkills:[NSArray array]];
    _opponent = [aResponse.opponentInfo retain];
    _startTime = aResponse.time;
    _currentTime = aResponse.time;
    _currentTurn = aResponse.currentTurn;
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
  
  for (NSDictionary *skillConditionDictionary in aResponse.skillsCondition)
  {
    NSInteger skillID = [skillConditionDictionary[kRPGSkillID] integerValue];
    NSInteger cooldown = [skillConditionDictionary[kRPGSkillCooldown] integerValue];
    
    for (RPGSkill *skill in self.player.skills)
    {
      if (skillID == skill.skillID)
      {
        skill.cooldown = cooldown;
      }
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
  
  [super dealloc];
}

@end
