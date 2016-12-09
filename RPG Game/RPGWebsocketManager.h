//
//  RPGWebsocketManager.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <SocketRocket/SocketRocket.h>
  // Controllers
@class RPGBattleController;
  // Misc
#import "RPGSerializable.h"

NS_ASSUME_NONNULL_BEGIN

@interface RPGWebsocketManager : SRWebSocket

@property (nonatomic, assign, readwrite) RPGBattleController *battleController;
@property (nonatomic, assign, readwrite) id<SRWebSocketDelegate> delegate;

- (instancetype)initWithURL:(NSURL *)anURL;

- (void)sendWebsocketManagerMessageWithObject:(nonnull id<RPGSerializable>)anObject;
- (void)sendWebsocketManagerMessageWithObject:(nonnull id<RPGSerializable>)anObject
                            shouldInjectToken:(BOOL)anInjectTokenFlag;

@end

NS_ASSUME_NONNULL_END