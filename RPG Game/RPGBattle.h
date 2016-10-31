//
//  RPGBattle.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGPlayer.h"

@class RPGBattleInitResponse;
@class RPGBattleConditionResponse;
@class RPGTimeResponse;

/**
 *  Model entity. Owns player and opponent entities, keeps server start time and
 *  current server time.
 */
@interface RPGBattle : NSObject

@property (retain, nonatomic, readonly) RPGPlayer *player;
@property (retain, nonatomic, readonly) RPGEntity *opponent;
@property (assign, nonatomic, readonly) NSInteger startTime;
@property (assign, nonatomic, readonly) NSInteger currentTime;

/**
 *  Inits model. Sets startTime, general player info.
 */
- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse;

+ (instancetype)battleWithBattleInitResponse:(RPGBattleInitResponse *)aResponse;

/**
 *  Updates whole model.
 *
 */
- (void)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse;

/**
 *  Updates currentTime property
 *
 */
- (void)updateWithTimeSynchResponse:(RPGTimeResponse *)aResponse;

@end
