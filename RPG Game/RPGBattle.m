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
#import "RPGSFXEngine.h"

@interface RPGBattle ()

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
  //TODO: remove hardcode
  NSInteger skillID = [[aResponse.skillsDamage valueForKey:@"skill_id"] integerValue];
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:skillID];
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
