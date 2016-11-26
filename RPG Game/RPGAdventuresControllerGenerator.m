//
//  RPGAdventuresControllerGenerator.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresControllerGenerator.h"
  // Controllers
#import "RPGAdventuresController.h"

static NSString * const kRPGAdventuresControllerBattleInitMessageType = @"BATTLE_INIT";
static NSString * const kRPGAdventuresControllerBattleConditionMessageType = @"BATTLE_CONDITION";

@implementation RPGAdventuresControllerGenerator

- (RPGBattleController *)battleController
{
  RPGAdventuresController *controller = [[[RPGAdventuresController alloc] init] autorelease];
  [controller registerWebSocketMessageTypeForBattleInitResponse:kRPGAdventuresControllerBattleInitMessageType];
  [controller registerWebSocketMessageTypeForBattleConditionResponse:kRPGAdventuresControllerBattleConditionMessageType];
  
  return controller;
}

@end
