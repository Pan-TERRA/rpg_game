//
//  RPGAdventuresConditionResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresConditionResponse.h"
  // Entity
#import "RPGPlayerInfo.h"
  // Constants
#import "RPGMessageTypes.h"

@implementation RPGAdventuresConditionResponse

- (instancetype)initWithPlayerInfo:(RPGPlayerInfo *)aPlayerInfo
                      opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                   skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                      skillsDamage:(NSDictionary *)aSkillsDamage
                      battleStatus:(RPGBattleStatus)aBattleStatus
                            reward:(RPGBattleReward *)aReward
                            status:(NSInteger)aStatus
                       currentTurn:(BOOL)aCurrentTurn
{
  return [super initWithType:kRPGAdventuresConditionMessageType
                  playerInfo:aPlayerInfo
                opponentInfo:anOpponentInfo
             skillsCondition:aSkillsCondition
                skillsDamage:aSkillsDamage
                battleStatus:aBattleStatus
                      reward:aReward
                      status:aStatus
                 currentTurn:aCurrentTurn];
}

+ (instancetype)battleConditionResponseWithPlayerInfo:(RPGPlayerInfo *)aPlayerInfo
                                         opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                                      skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                                         skillsDamage:(NSDictionary *)aSkillsDamage
                                         battleStatus:(RPGBattleStatus)aBattleStatus
                                               reward:(RPGBattleReward *)aReward
                                               status:(NSInteger)aStatus
                                          currentTurn:(BOOL)aCurrentTurn
{
  return [[[self alloc] initWithPlayerInfo:(RPGPlayerInfo *)aPlayerInfo
                              opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                           skillsCondition:aSkillsCondition
                              skillsDamage:aSkillsDamage
                              battleStatus:aBattleStatus
                                    reward:aReward
                                    status:aStatus
                               currentTurn:aCurrentTurn] autorelease];
}

- (instancetype)initWithType:(NSString *)aType
                  playerInfo:(RPGPlayerInfo *)aPlayerInfo
                opponentInfo:(RPGPlayerInfo *)anOpponentInfo
             skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                skillsDamage:(NSDictionary *)aSkillsDamage
                battleStatus:(RPGBattleStatus)aBattleStatus
                      reward:(RPGBattleReward *)aReward
                      status:(NSInteger)aStatus
                 currentTurn:(BOOL)aCurrentTurn
{
  return [self initWithPlayerInfo:aPlayerInfo
                     opponentInfo:anOpponentInfo
                  skillsCondition:aSkillsCondition
                     skillsDamage:aSkillsDamage
                     battleStatus:aBattleStatus
                           reward:aReward
                           status:aStatus
                      currentTurn:aCurrentTurn];
}

@end
