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

  // for KVO observing
@property(nonatomic, assign) id playerMasterProperty;
@property(nonatomic, assign) id opponentMasterProperty;

@property (retain, nonatomic, readwrite) RPGPlayer *player;
@property (retain, nonatomic, readonly) RPGEntity *opponent;
@property (assign, nonatomic, readonly) NSInteger startTime;
@property (assign, nonatomic, readonly) NSInteger currentTime;
@property (assign, nonatomic, readonly) RPGBattleStatus battleStatus;
@property (assign, nonatomic, readonly, getter=isCurrentTurn) BOOL currentTurn;
@property (retain, nonatomic, readonly) RPGBattleReward *reward;
@property (retain, nonatomic, readonly) RPGBattleLog *battleLog;

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
