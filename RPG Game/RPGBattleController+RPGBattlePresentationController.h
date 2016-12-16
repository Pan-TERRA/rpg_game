//
//  RPGBattleController+RPGBattlePresentationController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleController.h"
  // Constants
#import "RPGBattleStatus.h"
  // Entities
@class RPGSkill;
@class RPGBattleAction;

@interface RPGBattleController (RPGBattlePresentationController)

  // Player
@property (nonatomic, assign, readonly) NSString *playerNickName;
@property (nonatomic, assign, readonly) NSInteger playerHP;
@property (nonatomic, assign, readonly) NSInteger playerMaxHP;
@property (nonatomic, assign, readonly) NSInteger playerLevel;
@property (nonatomic, assign, readonly) NSArray<RPGSkill *> *skills;
@property (nonatomic, assign, readonly) NSUInteger skillsCount;
@property (nonatomic, assign, readonly, getter=isMyTurn) BOOL myTurn;
  // Opponent
@property (nonatomic, assign, readonly) NSString *opponentNickName;
@property (nonatomic, assign, readonly) NSInteger opponentHP;
@property (nonatomic, assign, readonly) NSInteger opponentMaxHP;
@property (nonatomic, assign, readonly) NSInteger opponentLevel;
  // General
@property (nonatomic, assign, readonly) RPGBattleStatus battleStatus;
@property (nonatomic, assign, readonly) NSString *attackerNickName;
@property (nonatomic, assign, readonly) NSString *defenderNickName;
@property (nonatomic, assign, readonly) NSInteger rewardGold;
@property (nonatomic, assign, readonly) NSInteger rewardCrystals;
@property (nonatomic, assign, readonly) NSInteger rewardExp;
@property (nonatomic, assign, readonly) NSArray<RPGBattleAction *> *actions;

@end
