//
//  RPGBattleFactoryProtocol.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPGBattleController;
@class RPGRewardViewController;

/**
 *  Abstract factory. Used by battleViewController and its subclasses
 */
@protocol RPGBattleFactoryProtocol <NSObject>

@property (retain, nonatomic, readonly) RPGBattleController *battleController;
@property (retain, nonatomic, readonly) RPGRewardViewController *rewardViewController;

@end
