//
//  RPGAdventuresConditionResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"

@interface RPGAdventuresConditionResponse : RPGBattleConditionResponse

- (instancetype)initWithHP:(NSInteger)aHP
                  opponentHP:(NSInteger)anOpponentHP
             skillsCondition:(NSArray *)aSkillsCondition
                skillsDamage:(NSDictionary *)aSkillsDamage
                battleStatus:(RPGBattleStatus)aBattleStatus
                      reward:(RPGBattleReward *)aReward
                      status:(NSInteger)aStatus
                 currentTurn:(BOOL)aCurrentTurn NS_DESIGNATED_INITIALIZER;

+ (instancetype)battleConditionResponseWithHP:(NSInteger)aHP
                                     opponentHP:(NSInteger)anOpponentHP
                                skillsCondition:(NSArray *)aSkillsCondition
                                   skillsDamage:(NSDictionary *)aSkillsDamage
                                   battleStatus:(RPGBattleStatus)aBattleStatus
                                         reward:(RPGBattleReward *)aReward
                                         status:(NSInteger)aStatus
                                    currentTurn:(BOOL)aCurrentTurn;

@end
