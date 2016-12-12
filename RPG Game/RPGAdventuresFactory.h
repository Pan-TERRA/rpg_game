//
//  RPGAdventuresFactory.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleFactory.h"

@interface RPGAdventuresFactory : RPGBattleFactory

- (instancetype)initWithBattleplaceID:(NSInteger)aBattleplaceID NS_DESIGNATED_INITIALIZER;

@end
