//
//  RPGBattleLog.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleLog.h"
  // Entities
#import "RPGBattleConditionResponse.h"
#import "RPGBattleAction.h"

NSString * const kRPGBattleLogSkillID = @"skill_id";
NSString * const kRPGBattleLogDamage = @"damage";

@interface RPGBattleLog ()

@property (retain, nonatomic, readwrite) NSMutableArray<RPGBattleAction *> *mutableActions;

@end

@implementation RPGBattleLog

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    _mutableActions = [NSMutableArray new];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_mutableActions release];
  
  [super dealloc];
}

#pragma mark - Actions

- (void)updateWithBattleConditionResponse:(RPGBattleConditionResponse *)aResponse
{
  NSDictionary *skillDamage = aResponse.skillsDamage;
  
  if (skillDamage != nil)
  {
    RPGBattleAction *action = [[RPGBattleAction alloc] initWithMyTurn:!aResponse.currentTurn
                                                              skillID:[skillDamage[kRPGBattleLogSkillID] integerValue]
                                                               damage:[skillDamage[kRPGBattleLogDamage] integerValue]];
    if (action != nil)
    {
      [self addAction:action];
      [action release];
    }
  }
}

#pragma mark - Accessors

- (NSArray<RPGBattleAction *> *)actions
{
  return self.mutableActions;
}

#pragma mark - KVC compliance for <actions>

- (void)addAction:(RPGBattleAction *)anAction
{
  [self insertObject:anAction inActionsAtIndex:self.mutableActions.count];
}

- (void)insertObject:(RPGBattleAction *)anObject inActionsAtIndex:(NSUInteger)anIndex
{
  [self.mutableActions addObject:anObject];
}

- (void)removeObjectFromActionsAtIndex:(NSUInteger)index
{
  [self.mutableActions removeObjectAtIndex:index];
}

@end
