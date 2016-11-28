//
//  RPGAdventuresController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // API
@class RPGWebsocketManager;
  // Controllers
#import "RPGBattleController.h"

@interface RPGAdventuresController : RPGBattleController

@property (retain, nonatomic, readonly) RPGWebsocketManager *webSocketManager;

- (instancetype)initWithWebSocketManager:(RPGWebsocketManager *)aManager;

@end
