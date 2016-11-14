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

extern NSString * const kRPGModelDidChangeNotification;
extern NSString * const kRPGBattleInitDidEndSetUpNotification;

@interface RPGBattleController : NSObject

@property (retain, nonatomic, readonly) RPGBattle *battle;
@property (nonatomic, assign, readonly, getter=isMyTurn) BOOL myTurn;
@property (nonatomic, assign, readonly) NSUInteger skillsCount;
@property (assign, nonatomic, readonly) NSArray<NSNumber *> *skillsID;

/**
 *  Prime initializer. Inits RPGBattle instance.
 *
 */
- (instancetype)init;

- (void)sendSkillActionRequestWithTag:(NSInteger)aTag;
//- (void)sendBattleInitRequest;
- (void)sendBattleConditionRequest;

- (void)processManagerResponse:(NSDictionary *)aResponse;
- (void)requestBattleInit;
- (void)prepareBattleControllerForDismiss;

@end
