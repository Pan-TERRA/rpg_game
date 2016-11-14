//
//  RPGBattleLog.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPGBattleAction;
@class RPGBattleConditionResponse;

/**
 *  Model entity. Owns array of action entities.
 */
@interface RPGBattleLog : NSObject

@property (retain, nonatomic, readonly) NSArray<RPGBattleAction *> *actions;

/**
 *  Updates model.
 *  Creates and adds new action to internal array.
 */
- (void)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse;

@end
