//
//  RPGBattleConditionResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"
#import "RPGMessageTypes.h"
#import "RPGBattleReward.h"
#import "RPGPlayerInfo.h"

NSString * const kRPGBattleConditionResponsePlayerInfo = @"player_info";
NSString * const kRPGBattleConditionResponseOpponentInfo = @"opponent_info";
NSString * const kRPGBattleConditionResponseSkillsCondition = @"skills_condition";
NSString * const kRPGBattleConditionResponseSkillsDamage = @"skills_damage";
NSString * const kRPGBattleConditionResponseReward = @"reward";
NSString * const kRPGBattleConditionResponseStatus = @"status";
NSString * const kRPGBattleConditionResponseBattleStatus = @"did_win";
NSString * const kRPGBattleConditionResponseCurrentTurn = @"is_current_turn";

@interface RPGBattleConditionResponse ()

@property (nonatomic, retain, readwrite) RPGPlayerInfo *playerInfo;
@property (nonatomic, retain, readwrite) RPGPlayerInfo *opponentInfo;
@property (nonatomic, retain, readwrite) NSMutableArray *mutableSkillsCondition;
@property (nonatomic, retain, readwrite) NSMutableDictionary *mutableSkillsDamage;
@property (nonatomic, assign, readwrite) RPGBattleStatus battleStatus;
@property (nonatomic, retain, readwrite) RPGBattleReward *reward;
@property (nonatomic, assign, readwrite, getter=isCurrentTurn) BOOL currentTurn;

@end

@implementation RPGBattleConditionResponse

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                  playerInfo:(RPGPlayerInfo *)aPlayerInfo
                opponentInfo:(RPGPlayerInfo *)anOpponentInfo
             skillsCondition:(NSArray *)aSkillsCondition
                skillsDamage:(NSDictionary *)aSkillsDamage
                battleStatus:(RPGBattleStatus)aBattleStatus
                      reward:(RPGBattleReward *)aReward
                      status:(NSInteger)aStatus
                 currentTurn:(BOOL)aCurrentTurn
{
  self = [super initWithType:aType
                      status:aStatus];
  
  if (self != nil)
  {
    if (aSkillsCondition == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _playerInfo = [aPlayerInfo retain];
      _opponentInfo = [anOpponentInfo retain];
      _mutableSkillsCondition = [aSkillsCondition mutableCopy];
      _mutableSkillsDamage = [aSkillsDamage mutableCopy];
      _battleStatus = aBattleStatus;
      _reward = [aReward retain];
      _currentTurn = aCurrentTurn;
    }
  }
  
  return self;
}

- (instancetype)initWithType:(NSString *)aType
                      status:(NSInteger)aStatus
{
  return [self initWithType:aType
                 playerInfo:nil
               opponentInfo:nil
            skillsCondition:nil
               skillsDamage:nil
               battleStatus:kRPGBattleStatusBattleInProgress
                     reward:nil
                     status:-1
                currentTurn:NO];
}

+ (instancetype)battleConditionResponseWithType:(NSString *)aType
                                     playerInfo:(RPGPlayerInfo *)aPlayerInfo
                                   opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                                skillsCondition:(NSArray *)aSkillsCondition
                                   skillsDamage:(NSDictionary *)aSkillsDamage
                                   battleStatus:(RPGBattleStatus)aBattleStatus
                                         reward:(RPGBattleReward *)aReward
                                         status:(NSInteger)aStatus
                                    currentTurn:(BOOL)aCurrentTurn
{
  return [[[self alloc] initWithType:aType
                          playerInfo:aPlayerInfo
                        opponentInfo:anOpponentInfo
                     skillsCondition:aSkillsCondition
                        skillsDamage:aSkillsDamage
                        battleStatus:aBattleStatus
                              reward:aReward
                              status:aStatus
                         currentTurn:aCurrentTurn] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_playerInfo release];
  [_opponentInfo release];
  [_mutableSkillsCondition release];
  [_mutableSkillsDamage release];
  [_reward release];
  
  [super dealloc];
}

#pragma mark - Accessors

- (NSArray *)skillsCondition
{
  return self.mutableSkillsCondition;
}

- (NSDictionary *)skillsDamage
{
  return self.mutableSkillsDamage;
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  dictionaryRepresentation[kRPGBattleConditionResponsePlayerInfo] = [self.playerInfo dictionaryRepresentation];
  dictionaryRepresentation[kRPGBattleConditionResponseOpponentInfo] = [self.opponentInfo dictionaryRepresentation];
  dictionaryRepresentation[kRPGBattleConditionResponseSkillsCondition] = self.skillsCondition;
  dictionaryRepresentation[kRPGBattleConditionResponseSkillsDamage] = self.skillsDamage;
  dictionaryRepresentation[kRPGBattleConditionResponseReward] = [self.reward dictionaryRepresentation];
  dictionaryRepresentation[kRPGBattleConditionResponseStatus] = @(self.status);
  dictionaryRepresentation[kRPGBattleConditionResponseCurrentTurn] = @(self.currentTurn);
  dictionaryRepresentation[kRPGBattleConditionResponseBattleStatus] = @(self.battleStatus);
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGBattleReward *reward = [[[RPGBattleReward alloc] initWithDictionaryRepresentation:aDictionary[kRPGBattleConditionResponseReward]] autorelease];
  RPGPlayerInfo *playerInfo = [[[RPGPlayerInfo alloc] initWithDictionaryRepresentation:aDictionary[kRPGBattleConditionResponsePlayerInfo]] autorelease];
  RPGPlayerInfo *opponentInfo = [[[RPGPlayerInfo alloc] initWithDictionaryRepresentation:aDictionary[kRPGBattleConditionResponseOpponentInfo]] autorelease];
  
  return [self initWithType:aDictionary[kRPGResponseSerializationType]
                 playerInfo:playerInfo
               opponentInfo:opponentInfo
            skillsCondition:aDictionary[kRPGBattleConditionResponseSkillsCondition]
               skillsDamage:aDictionary[kRPGBattleConditionResponseSkillsDamage]
               battleStatus:[aDictionary[kRPGBattleConditionResponseBattleStatus] integerValue]
                     reward:reward
                     status:[aDictionary[kRPGBattleConditionResponseStatus] integerValue]
                currentTurn:[aDictionary[kRPGBattleConditionResponseCurrentTurn] boolValue]];
}

@end
