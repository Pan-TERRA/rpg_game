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

@interface RPGWebsocketManager : NSObject

@property (assign, nonatomic, readwrite) RPGBattleController *battleController;
@property (retain, nonatomic, readonly) NSURL *URL;

- (instancetype)initWithURL:(NSURL *)anURL;

- (void)open;
- (void)close;

- (void)sendWebsocketManagerMessageWithObject:(nonnull id<RPGSerializable>)anObject;
- (void)sendWebsocketManagerMessageWithObject:(nonnull id<RPGSerializable>)anObject shouldInjectToken:(BOOL)anInjectTokenFlag;

@end

NS_ASSUME_NONNULL_END