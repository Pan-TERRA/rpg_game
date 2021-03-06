//
//  RPGMessageTypes.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/31/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGMessageTypes.h"

  // Tournament
NSString * const kRPGTournamentInitMessageType = @"TOURNAMENT_BATTLE_INIT";
NSString * const kRPGTournamentConditionMessageType = @"PVP_BATTLE_CONDITION";
  // Arena
NSString * const kRPGArenaInitMessageType = @"ARENA_BATTLE_INIT";
NSString * const kRPGArenaConditionMessageType = @"PVP_BATTLE_CONDITION";
  // Adventures
NSString * const kRPGAdventuresInitMessageType = @"ADVENTURE_BATTLE_INIT";
NSString * const kRPGAdventuresConditionMessageType = @"ADVENTURE_BATTLE_CONDITION";
  // General
NSString * const kRPGSkillActionMessageType = @"SKILL_ACTION";
NSString * const kRPGTimeRequestMessageType = @"TIME_REQUEST";
