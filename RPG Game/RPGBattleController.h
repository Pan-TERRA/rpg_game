//
//  RPGBattleController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RPGBattle;
@class RPGWebsocketManager;
@class RPGRequest;
@class RPGSkill;

extern NSString * const kRPGModelDidChangeNotification;
extern NSString * const kRPGBattleInitDidEndSetUpNotification;

@interface RPGBattleController : NSObject

@property (retain, nonatomic, readonly) RPGBattle *battle;

/**
 *  Prime initializer. Inits RPGBattle instance.
 *
 */
- (instancetype)init;

#pragma mark - API

- (void)sendSkillActionRequestWithSkillID:(NSInteger)aSkillID;

/**
 *  May be overriden to send proper request
 */
- (RPGRequest *)createBattleInitRequest;

- (void)sendBattleConditionRequest;

- (void)processManagerResponse:(NSDictionary *)aResponse;

/**
 *  May be overriden to get player skills from other source.
 *  These skills will be used in battle.
 */
- (NSArray<NSNumber *> *)getPlayerSkillIDs;

- (void)requestBattleInit;
- (void)prepareBattleControllerForDismiss;

@end
