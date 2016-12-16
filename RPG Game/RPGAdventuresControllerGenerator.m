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

#pragma mark - Init

- (instancetype)initWithStageID:(NSInteger)aStageID
{
  self = [super init];
  
  if (self != nil)
  {
    if (aStageID > 0)
    {
      _stageID = aStageID;
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithStageID:-1];
}

#pragma mark - RPGBattleControllerGenerator

- (RPGBattleController *)battleController
{
  RPGWebsocketManager *manager = [[RPGWebsocketManager alloc] initWithURL:[NSURL URLWithString:kRPGWebsocketManagerAPIMonsterBattle]];
  RPGAdventuresController *controller = [[[RPGAdventuresController alloc] initWithWebSocketManager:manager
                                                                                           stageID:self.stageID] autorelease];
  manager.battleController = controller;
  [manager release];
  
  [controller registerWebSocketMessageTypeForBattleInitResponse:kRPGAdventuresInitMessageType];
  [controller registerWebSocketMessageTypeForBattleConditionResponse:kRPGAdventuresConditionMessageType];
  
  return controller;
}

@end
