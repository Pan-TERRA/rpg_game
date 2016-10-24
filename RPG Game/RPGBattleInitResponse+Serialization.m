//
//  RPGBattleInitResponse+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleInitResponse+Serialization.h"
#import "RPGResponse+Serialization.h"
#import "RPGEntity+Serialization.h"

static NSString * const kRPGBattleInitResponseOpponentInfo = @"opponent_info";
static NSString * const kRPGBattleInitResponseOpponentTime = @"time";
static NSString * const kRPGBattleInitResponseCurrentTurn = @"is_current_turn";

@implementation RPGBattleInitResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGBattleInitResponseOpponentInfo] = [self.opponentInfo dictionaryRepresentation];
  dictionaryRepresentation[kRPGBattleInitResponseCurrentTurn] = [NSNumber numberWithBool:self.isCurrentTurn];
  dictionaryRepresentation[kRPGBattleInitResponseOpponentTime] = @(self.time);

  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGEntity *opponentInfo = [[RPGEntity alloc] initWithDictionaryRepresentation:aDictionary[kRPGBattleInitResponseOpponentInfo]];
  BOOL currentTurn = [aDictionary[kRPGBattleInitResponseCurrentTurn] boolValue];
  NSInteger status = [aDictionary[kRPGResponseSerializationStatus] integerValue];
  NSInteger time = [aDictionary[kRPGBattleInitResponseOpponentTime] integerValue];
  
  return [self initWithOpponentInfo:opponentInfo currentTurn:currentTurn  time:time status:status];
}

@end
