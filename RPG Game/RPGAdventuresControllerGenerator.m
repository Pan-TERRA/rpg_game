//
//  RPGAdventuresControllerGenerator.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresControllerGenerator.h"
  // API
#import "RPGWebsocketManager.h"
  // Controllers
#import "RPGAdventuresController.h"
  // Constants
#import "RPGMessageTypes.h"

static NSString * const kRPGWebsocketManagerAPIMonsterBattle = @"ws://10.55.33.15:8888/monster_battle";

@implementation RPGAdventuresControllerGenerator

- (RPGBattleController *)battleController
{
  RPGWebsocketManager *manager = [[RPGWebsocketManager alloc] initWithURL:[NSURL URLWithString:kRPGWebsocketManagerAPIMonsterBattle]];
  RPGAdventuresController *controller = [[[RPGAdventuresController alloc] initWithWebSocketManager:manager] autorelease];
  manager.battleController = controller;
  [manager release];
  
  [controller registerWebSocketMessageTypeForBattleInitResponse:kRPGAdventuresInitMessageType];
  [controller registerWebSocketMessageTypeForBattleConditionResponse:kRPGAdventuresConditionMessageType];
  
  return controller;
}

@end
