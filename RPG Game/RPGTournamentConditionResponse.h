//
//  RPGTournamentConditionResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"
  // Constants
#import "RPGBattleStatus.h"
#import "RPGStatusCodes.h"
  // Entities
@class RPGPlayerInfo;
@class RPGBattleReward;

@interface RPGTournamentConditionResponse : RPGBattleConditionResponse

- (instancetype)initWithPlayerInfo:(RPGPlayerInfo *)aPlayerInfo
                      opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                   skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                      skillsDamage:(NSDictionary *)aSkillsDamage
                      battleStatus:(RPGBattleStatus)aBattleStatus
                            reward:(RPGBattleReward *)aReward
                            status:(RPGStatusCode)aStatus
                       currentTurn:(BOOL)aCurrentTurn NS_DESIGNATED_INITIALIZER;

+ (instancetype)battleConditionResponseWithPlayerInfo:(RPGPlayerInfo *)aPlayerInfo
                                         opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                                      skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                                         skillsDamage:(NSDictionary *)aSkillsDamage
                                         battleStatus:(RPGBattleStatus)aBattleStatus
                                               reward:(RPGBattleReward *)aReward
                                               status:(RPGStatusCode)aStatus
                                          currentTurn:(BOOL)aCurrentTurn;

@end
