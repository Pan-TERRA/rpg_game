//
//  RPGBattleFactory.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPGBattleController;
@class RPGRewardViewController;

@interface RPGBattleFactory : NSObject

@property (retain, nonatomic, readonly) RPGBattleController *battleController;
@property (retain, nonatomic, readonly) RPGRewardViewController *rewardViewController;

@end
