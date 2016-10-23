//
//  RPGBattleManager.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>

@interface RPGBattleManager : SRWebSocket

/**
 *  SRWebsocket delegate, usually view controller. Handle response messages.
 */
@property (nonatomic, assign) id <SRWebSocketDelegate>delegate;

- (void)sendSpellActionRequestWithID:(NSInteger)anID;
- (void)sendBattleInitRequest;
- (void)sendBattleCondtionRequest;
- (void)sendTimeSynchRequest;

@end
