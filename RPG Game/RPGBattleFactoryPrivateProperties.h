//
//  RPGBattleFactoryPrivateProperties.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#ifndef RPGBattleFactoryPrivateProperties_h
#define RPGBattleFactoryPrivateProperties_h

@interface RPGBattleFactory ()

@property (retain, nonatomic, readwrite) RPGBattleController *battleController;
@property (retain, nonatomic, readwrite) RPGRewardViewController *rewardViewController;

@end

#endif /* RPGBattleFactoryPrivateProperties_h */
