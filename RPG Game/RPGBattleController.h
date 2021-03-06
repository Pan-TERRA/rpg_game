//
//  RPGBattleController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // API
@class RPGWebsocketManager;
  // Entities
@class RPGBattle;
@class RPGRequest;

  // Notifications
extern NSString * const kRPGModelDidChangeNotification;
extern NSString * const kRPGBattleInitDidEndSetUpNotification;
  // User info keys
extern NSString * const kRPGBattleControllerUserInfoErrorCodeKey;

@interface RPGBattleController : NSObject

@property (nonatomic, retain, readwrite) RPGBattle *battle;
@property (nonatomic, retain, readonly) RPGWebsocketManager *webSocketManager;

  // supported websocket messages
@property (nonatomic, copy, readonly) NSString *battleInitWebSocketMessageType;
@property (nonatomic, copy, readonly) NSString *battleConditionWebSocketMessageType;

- (instancetype)initWithWebSocketManager:(RPGWebsocketManager *)aManager;

#pragma mark - Creating Request

  // must be overriden to send proper request
- (RPGRequest *)createBattleInitRequest;

  // must be overriden to send proper request
- (RPGRequest *)createBattleConditionRequest;

#pragma mark - Proccess Manager Response

/**
 *  Process websocket message.
 *
 *  @param aResponse A websocket message represented as dictionar
 */
- (void)processManagerResponse:(NSDictionary *)aResponse NS_REQUIRES_SUPER;

#pragma mark Battle Init Response

- (void)registerWebSocketMessageTypeForBattleInitResponse:(NSString *)aMessageType;

  // template method
- (void)processBattleInitResponse:(NSDictionary *)aResponse;

#pragma mark Battle Condition Response

- (void)registerWebSocketMessageTypeForBattleConditionResponse:(NSString *)aMessageType;

  // template method
- (void)processBattleConditionResponse:(NSDictionary *)aResponse;

#pragma mark  - Actions

- (void)sendSkillActionRequestWithSkillID:(NSInteger)aSkillID;

#pragma mark - Misc

/**
 *  Request for battle init. Usually invoked by WebSocket Manager after socket opening.
 */
- (void)requestBattleInit;

  //  invoke it when showing view controller
- (void)fireUpBattleController;

  //  invoke it when dismissing view controller
- (void)prepareBattleControllerForDismiss;
- (void)prepareBattleControllerForDismissWithCompletionHandler:(void (^)(void))callbackBlock;

  //  invoked by WebSocketManager delegate
- (void)dismissalDidFinish;

@end
