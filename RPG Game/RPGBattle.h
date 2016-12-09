//
//  RPGBattle.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Constants
#import "RPGBattleStatus.h"
  // Entities
@class RPGEntity;
@class RPGPlayer;
@class RPGBattleLog;
@class RPGBattleInitResponse;
@class RPGBattleConditionResponse;
@class RPGTimeResponse;
@class RPGBattleReward;

extern const NSInteger kRPGBattleTurnDuration;

/**
 *  Model entity. Owns player and opponent entities, keeps server start time and
 *  current server time.
 */
@interface RPGBattle : NSObject

@property (nonatomic, retain, readwrite) RPGPlayer *player;
@property (nonatomic, retain, readonly) RPGEntity *opponent;
@property (nonatomic, assign, readonly) NSInteger startTime;
@property (nonatomic, assign, readonly) NSInteger currentTime;
@property (nonatomic, assign, readonly) RPGBattleStatus battleStatus;
@property (nonatomic, assign, readonly, getter=isCurrentTurn) BOOL currentTurn;
@property (nonatomic, retain, readonly) RPGBattleReward *reward;
@property (nonatomic, retain, readonly) RPGBattleLog *battleLog;

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
