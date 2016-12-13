//
//  RPGArenaControllerGenerator.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaControllerGenerator.h"
  // API
#import "RPGWebsocketManager.h"
  // Controllers
#import "RPGArenaController.h"
  // Constants
#import "RPGMessageTypes.h"

static NSString * const kRPGWebsocketManagerAPIArenaBattle = @"ws://10.55.33.15:8888/arena_battle";

@implementation RPGArenaControllerGenerator

- (RPGBattleController *)battleController
{
  RPGWebsocketManager *manager = [[RPGWebsocketManager alloc] initWithURL:[NSURL URLWithString:kRPGWebsocketManagerAPIArenaBattle]];
  RPGArenaController *controller = [[[RPGArenaController alloc] initWithWebSocketManager:manager] autorelease];
  manager.battleController = controller;
  [manager release];
  
  [controller registerWebSocketMessageTypeForBattleInitResponse:kRPGArenaInitMessageType];
  [controller registerWebSocketMessageTypeForBattleConditionResponse:kRPGArenaConditionMessageType];
  
  return controller;
}

@end
