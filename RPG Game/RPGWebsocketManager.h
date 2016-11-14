//
//  RPGWebsocketManager.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>
#import "RPGSerializable.h"

@class RPGBattleController;

@interface RPGWebsocketManager : SRWebSocket

@property (nonatomic, assign) id <SRWebSocketDelegate>delegate;

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController;

- (void)sendWebsocketManagerMessageWithObject:(id<RPGSerializable>)anObject;

@end
