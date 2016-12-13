//
//  RPGBattleFactory.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Controlelers
@class RPGRewardViewController;
@class RPGBattleController;

@interface RPGBattleFactory : NSObject

@property (retain, nonatomic, readonly) RPGBattleController *battleController;
@property (retain, nonatomic, readonly) RPGRewardViewController *rewardViewController;

@end
