//
//  RPGAdventuresController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

  // API
@class RPGWebsocketManager;
  // Controllers
#import "RPGBattleController.h"

@interface RPGAdventuresController : RPGBattleController

@property (nonatomic, assign, readwrite) NSInteger stageID;

- (instancetype)initWithWebSocketManager:(RPGWebsocketManager *)aManager stageID:(NSInteger)aStageID;

@end
