//
//  RPGAdventuresControllerGenerator.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleControllerGenerator.h"

@interface RPGAdventuresControllerGenerator : RPGBattleControllerGenerator

- (instancetype)initWithStageID:(NSInteger)aStageID NS_DESIGNATED_INITIALIZER;

@property (readwrite, assign, nonatomic) NSInteger stageID;

@end
