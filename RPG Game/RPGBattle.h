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

@interface RPGBattle : NSObject

@property (retain, nonatomic, readonly) RPGPlayer <RPGClientEntity>*player;
@property (retain, nonatomic, readonly) RPGPlayer *opponent;
@property (assign, nonatomic, readonly) NSInteger *startTime;
@property (assign, nonatomic, readonly) NSInteger *currentTime;

- (instancetype)initWithBattleInitResponse:(RPGBattleInitResponse *)aResponse;
- (instancetype)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse;
- (instancetype)updateWithTimeSynchResponse:(RPGTimeResponse *)aResponse;

@end
