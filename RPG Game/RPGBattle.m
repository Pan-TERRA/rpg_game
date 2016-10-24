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

@synthesize spells = _spells;

#pragma mark - Init

- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  self = [super init];
  
  if (self != nil)
  {
    _player = [[RPGPlayer alloc] initWithSpells:<#(NSArray *)#>]
  }
}

- (instancetype)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse {
	
}

- (instancetype)updateWithTimeSynchResponse:(RPGTimeResponse *)aResponse {
	
}
@end
