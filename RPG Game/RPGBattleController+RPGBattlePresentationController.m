//
//  RPGBattleController+RPGBattlePresentationController.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleController+RPGBattlePresentationController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGBattleLog.h"
#import "RPGBattleReward.h"

@implementation RPGBattleController (RPGBattlePresentationController)

#pragma mark  Player

- (NSString *)playerNickName
{
  return self.battle.player.name;
}

- (NSInteger)playerHP
{
  return self.battle.player.HP;
}

- (NSInteger)playerMaxHP
{
  return self.battle.player.maxHP;
}

- (NSInteger)playerLevel
{
  return self.battle.player.level;
}

- (BOOL)isMyTurn
{
  return self.battle.isCurrentTurn;
}

- (NSUInteger)skillsCount
{
  return self.battle.player.skills.count;
}

- (NSArray<RPGSkill *> *)skills
{
  return self.battle.player.skills;
}

- (NSInteger)playerCurrentWinCount
{
  return self.battle.player.currentWinCount;
}

#pragma mark  Opponent

- (NSString *)opponentNickName
{
  return self.battle.opponent.name;
}

- (NSInteger)opponentHP
{
  return self.battle.opponent.HP;
}

- (NSInteger)opponentMaxHP
{
  return self.battle.opponent.maxHP;
}

- (NSInteger)opponentLevel
{
  return self.battle.opponent.level;
}

#pragma mark  General

- (NSInteger)rewardGold
{
  return self.battle.reward.gold;
}

- (NSInteger)rewardCrystals
{
  return self.battle.reward.crystals;
}

- (NSInteger)rewardExp
{
  return self.battle.reward.exp;
}

- (NSArray *)actions
{
  return self.battle.battleLog.actions;
}

- (NSString *)attackerNickName
{
  return self.myTurn ? self.playerNickName : self.opponentNickName;
}

- (NSString *)defenderNickName
{
  return !self.myTurn ? self.playerNickName : self.opponentNickName;
}

- (RPGBattleStatus)battleStatus
{
  return self.battle.battleStatus;
}

@end
