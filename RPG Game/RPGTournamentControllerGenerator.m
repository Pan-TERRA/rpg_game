//
//  RPGTournamentControllerGenerator.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaControllerGenerator.h"
// API
#import "RPGWebsocketManager.h"
// Controllers
#import "RPGTournamentController.h"
// Constants
#import "RPGMessageTypes.h"

static NSString * const kRPGWebsocketManagerAPIArenaBattle = @"ws://10.55.33.15:8888/tournament_battle";

@implementation RPGTournamentControllerGenerator

- (RPGBattleController *)battleController
{
  RPGWebsocketManager *manager = [[RPGWebsocketManager alloc] initWithURL:[NSURL URLWithString:kRPGWebsocketManagerAPIArenaBattle]];
  RPGTournamentController *controller = [[[RPGTournamentController alloc] initWithWebSocketManager:manager] autorelease];
  manager.battleController = controller;
  [manager release];
  
  [controller registerWebSocketMessageTypeForBattleInitResponse:kRPGTournamentInitMessageType];
  [controller registerWebSocketMessageTypeForBattleConditionResponse:kRPGTournamentConditionMessageType];
  
  return controller;
}

@end
