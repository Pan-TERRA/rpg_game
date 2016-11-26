//
//  RPGArenaController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleController.h"

@interface RPGArenaController : RPGBattleController

@property (retain, nonatomic, readwrite) RPGWebsocketManager *webSocketManager;
@property (nonatomic, retain, readwrite) NSArray<NSNumber *> *skillsID;

@end
