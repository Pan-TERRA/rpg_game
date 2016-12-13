//
//  RPGAdventuresConditionResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"

@class RPGPlayerInfo;

@interface RPGAdventuresConditionResponse : RPGBattleConditionResponse

- (instancetype)initWithPlayerInfo:(RPGPlayerInfo *)aPlayerInfo
                      opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                   skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                      skillsDamage:(NSDictionary *)aSkillsDamage
                      battleStatus:(RPGBattleStatus)aBattleStatus
                            reward:(RPGBattleReward *)aReward
                            status:(NSInteger)aStatus
                       currentTurn:(BOOL)aCurrentTurn NS_DESIGNATED_INITIALIZER;

+ (instancetype)battleConditionResponseWithPlayerInfo:(RPGPlayerInfo *)aPlayerInfo
                                         opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                                      skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                                         skillsDamage:(NSDictionary *)aSkillsDamage
                                         battleStatus:(RPGBattleStatus)aBattleStatus
                                               reward:(RPGBattleReward *)aReward
                                               status:(NSInteger)aStatus
                                          currentTurn:(BOOL)aCurrentTurn;

@end
