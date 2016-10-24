//
//  RPGBattleConditionResponse+Serialization.m
//  RPG Game
//
//  Created by Степан Супинский on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse+Serialization.h"
#import "RPGResponse+Serialization.h"

NSString * const kRPGBattleConditionResponseHP = @"HP";
NSString * const kRPGBattleConditionResponseOpponentHP = @"OpponentHP";
NSString * const kRPGBattleConditionResponseSpellsCondition = @"SpellsCondition";
NSString * const kRPGBattleConditionResponseReward = @"Reward";
NSString * const kRPGBattleConditionResponseStatus = @"Status";

@implementation RPGBattleConditionResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  dictionaryRepresentation[kRPGBattleConditionResponseHP] = @(self.HP);
  dictionaryRepresentation[kRPGBattleConditionResponseOpponentHP] = @(self.opponentHP);
  dictionaryRepresentation[kRPGBattleConditionResponseSpellsCondition] = self.spellsCondition;
  dictionaryRepresentation[kRPGBattleConditionResponseReward] = self.reward;
  dictionaryRepresentation[kRPGBattleConditionResponseStatus] = @(self.status);
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithHP:[aDictionary[kRPGBattleConditionResponseHP] integerValue]
               opponentHP:[aDictionary[kRPGBattleConditionResponseOpponentHP] integerValue]
          spellsCondition:aDictionary[kRPGBattleConditionResponseSpellsCondition]
                   reward:aDictionary[kRPGBattleConditionResponseReward]
                   status:[aDictionary[kRPGBattleConditionResponseStatus] integerValue]];
}

@end
