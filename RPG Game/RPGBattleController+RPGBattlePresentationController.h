//
//  RPGBattleController+RPGBattlePresentationController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleController.h"

@class RPGSkill;

@interface RPGBattleController (RPGBattlePresentationController)

  // Player
@property (assign, nonatomic, readonly) NSString *playerNickName;
@property (assign, nonatomic, readonly) NSInteger playerHP;
@property (assign, nonatomic, readonly) NSArray<RPGSkill *> *skills;
@property (nonatomic, assign, readonly) NSUInteger skillsCount;
@property (nonatomic, assign, readonly, getter=isMyTurn) BOOL myTurn;
  // Opponent
@property (assign, nonatomic, readonly) NSString *opponentNickName;
@property (assign, nonatomic, readonly) NSInteger opponentHP;
  // General
@property (assign, nonatomic, readonly) NSString *attackerNickName;
@property (assign, nonatomic, readonly) NSString *defenderNickName;
@property (assign, nonatomic, readonly) NSInteger rewardGold;
@property (assign, nonatomic, readonly) NSArray *actions;

@end
