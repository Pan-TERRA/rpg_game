//
//  RPGBattle.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattle.h"
  // Entities
#import "RPGBattleInitResponse+Serialization.h"
#import "RPGPlayer.h"

@interface RPGBattle ()

@end

@implementation RPGBattle

#pragma mark - Init

- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  self = [super init];
  
  if (self != nil)
  {
    _player = [[RPGPlayer alloc] initWithSpells:[NSArray array]];
    _opponent = [aResponse.opponentInfo retain];
    _startTime = aResponse.time;
    _currentTime = aResponse.time;
  }
  
  return self;
}

- (instancetype)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse
{
  return nil;
}

- (instancetype)updateWithTimeSynchResponse:(RPGTimeResponse *)aResponse
{
  return nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_player release];
  [_opponent release];
  
  [super dealloc];
}

@end
