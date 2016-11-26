//
//  RPGBattleController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPGBattle;
@class RPGRequest;
@class RPGWebsocketManager;

extern NSString * const kRPGModelDidChangeNotification;
extern NSString * const kRPGBattleInitDidEndSetUpNotification;

@interface RPGBattleController : NSObject

@property (retain, nonatomic, readwrite) RPGBattle *battle;

@property (copy, nonatomic, readonly) NSString *battleInitWebSocketMessageType;
@property (copy, nonatomic, readonly) NSString *battleConditionWebSocketMessageType;

- (instancetype)init;

#pragma mark - API

- (void)processManagerResponse:(NSDictionary *)aResponse;

#pragma mark Battle Init

- (void)registerWebSocketMessageTypeForBattleInitResponse:(NSString *)aMessageType;
- (void)processBattleInitResponse:(NSDictionary *)aResponse;

/**
 *  May be overriden to send proper request
 */
- (RPGRequest *)createBattleInitRequest;

/**
 *  Request for battle init. Usually invoked by WebSocket Manager.
 */
- (void)requestBattleInit;

#pragma mark Battle Condtion

- (void)registerWebSocketMessageTypeForBattleConditionResponse:(NSString *)aMessageType;
- (void)processBattleConditionResponse:(NSDictionary *)aResponse;
- (void)sendBattleConditionRequest;

#pragma mark Skill Action

- (void)sendSkillActionRequestWithSkillID:(NSInteger)aSkillID;

/**
 *  May be overriden to get player skills from other source.
 *  These skills will be used in battle.
 */
- (NSArray<NSNumber *> *)getPlayerSkillIDs;

#pragma mark Misc

- (void)openBattleControllerWebSocket;

/**
 *  Inoke it when dismissing view controller.
 */
- (void)prepareBattleControllerForDismiss;

@end
