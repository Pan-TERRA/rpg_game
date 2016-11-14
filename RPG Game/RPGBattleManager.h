//
//  RPGBattleManager.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>

@class RPGBattle;

extern NSString * const kRPGBattleManagerDidEndSetUpNotification;
extern NSString * const kRPGModelDidChangeNotification;

/**
 *  Provides basic socket interaction. Holds RPGBattle instance.
 *  
 * @warning Self-delegated.
 */
@interface RPGBattleManager : SRWebSocket

@property (retain, nonatomic, readonly) RPGBattle *battle;
@property (nonatomic, assign) id <SRWebSocketDelegate>delegate;

/**
 *  Prime initializer. Inits RPGBattle instance.
 *
 */
- (instancetype)init;


- (void)sendSkillActionRequestWithID:(NSInteger)anID;
- (void)sendBattleInitRequest;
- (void)sendBattleConditionRequest;

/**
 *  Sends time request. Dipatches it every 5 seconds.
 */
- (void)sendTimeSynchRequest;

@end
