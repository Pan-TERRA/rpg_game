//
//  RPGArenaController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleController.h"

@class RPGSkill;

@interface RPGArenaController : RPGBattleController

@property (nonatomic, retain, readwrite) NSArray<RPGSkill *> *skills;

@end
