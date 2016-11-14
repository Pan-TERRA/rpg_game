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
  // Player
@property (assign, nonatomic, readonly) NSString *playerNickName;
@property (assign, nonatomic, readonly) NSInteger playerHP;
@property (assign, nonatomic, readonly) NSArray<NSNumber *> *skillsID;
@property (nonatomic, assign, readonly) NSUInteger skillsCount;
@property (nonatomic, assign, readonly, getter=isMyTurn) BOOL myTurn;
  // Opponent
@property (assign, nonatomic, readonly) NSString *opponentNickName;
@property (assign, nonatomic, readonly) NSInteger opponentHP;
  // General
@property (assign, nonatomic, readonly) NSInteger rewardGold;


/**
 *  Prime initializer. Inits RPGBattle instance.
 *
 */
- (instancetype)init;

#pragma mark - API

- (void)sendSkillActionRequestWithTag:(NSInteger)aTag;
- (void)sendBattleConditionRequest;

- (void)processManagerResponse:(NSDictionary *)aResponse;
- (void)requestBattleInit;
- (void)prepareBattleControllerForDismiss;

@end
