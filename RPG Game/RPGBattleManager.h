//
//  RPGBattleManager.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>

@class RPGBattle;

@interface RPGBattleManager : SRWebSocket

@property (retain, nonatomic, readonly) RPGBattle *battle;
@property (nonatomic, assign) id <SRWebSocketDelegate>delegate;

- (instancetype)init;

- (void)sendSpellActionRequestWithID:(NSInteger)anID;
//- (void)sendBattleInitRequest;
- (void)sendBattleCondtionRequest;
- (void)sendTimeSynchRequest;

@end
