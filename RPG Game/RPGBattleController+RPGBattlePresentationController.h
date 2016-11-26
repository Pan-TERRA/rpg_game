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

@class RPGSkill;

@interface RPGBattleController (RPGBattlePresentationController)

  // Player
@property (assign, nonatomic, readonly) NSString *playerNickName;
@property (assign, nonatomic, readonly) NSInteger playerHP;
@property (assign, nonatomic, readonly) NSInteger playerMaxHP;
@property (assign, nonatomic, readonly) NSArray<RPGSkill *> *skills;
@property (nonatomic, assign, readonly) NSUInteger skillsCount;
@property (nonatomic, assign, readonly, getter=isMyTurn) BOOL myTurn;
  // Opponent
@property (assign, nonatomic, readonly) NSString *opponentNickName;
@property (assign, nonatomic, readonly) NSInteger opponentHP;
@property (assign, nonatomic, readonly) NSInteger opponentMaxHP;
  // General
@property (assign, nonatomic, readonly) RPGBattleStatus battleStatus;
@property (assign, nonatomic, readonly) NSString *attackerNickName;
@property (assign, nonatomic, readonly) NSString *defenderNickName;
@property (assign, nonatomic, readonly) NSInteger rewardGold;
@property (assign, nonatomic, readonly) NSInteger rewardCrystals;
@property (assign, nonatomic, readonly) NSInteger rewardExp;
@property (assign, nonatomic, readonly) NSArray *actions;

@end
