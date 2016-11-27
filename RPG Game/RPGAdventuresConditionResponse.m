//
//  RPGAdventuresConditionResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresConditionResponse.h"
  // Constants
#import "RPGMessageTypes.h"

@implementation RPGAdventuresConditionResponse

- (instancetype)initWithHP:(NSInteger)aHP
                  opponentHP:(NSInteger)anOpponentHP
             skillsCondition:(NSArray *)aSkillsCondition
                skillsDamage:(NSDictionary *)aSkillsDamage
                battleStatus:(RPGBattleStatus)aBattleStatus
                      reward:(RPGBattleReward *)aReward
                      status:(NSInteger)aStatus
                 currentTurn:(BOOL)aCurrentTurn
{
  return [super initWithType:kRPGAdventuresConditionMessageType
                          HP:aHP
                  opponentHP:anOpponentHP
             skillsCondition:aSkillsCondition
                skillsDamage:aSkillsDamage
                battleStatus:aBattleStatus
                      reward:aReward
                      status:aStatus
                 currentTurn:aCurrentTurn];
}

+ (instancetype)battleConditionResponseWithHP:(NSInteger)aHP
                                     opponentHP:(NSInteger)anOpponentHP
                                skillsCondition:(NSArray *)aSkillsCondition
                                   skillsDamage:(NSDictionary *)aSkillsDamage
                                   battleStatus:(RPGBattleStatus)aBattleStatus
                                         reward:(RPGBattleReward *)aReward
                                         status:(NSInteger)aStatus
                                    currentTurn:(BOOL)aCurrentTurn
{
  return [[[self alloc] initWithHP:aHP
                          opponentHP:anOpponentHP
                     skillsCondition:aSkillsCondition
                        skillsDamage:aSkillsDamage
                        battleStatus:aBattleStatus
                              reward:aReward
                              status:aStatus
                         currentTurn:aCurrentTurn] autorelease];
}

- (instancetype)initWithType:(NSString *)aType
                          HP:(NSInteger)aHP
                  opponentHP:(NSInteger)anOpponentHP
             skillsCondition:(NSArray *)aSkillsCondition
                skillsDamage:(NSDictionary *)aSkillsDamage
                battleStatus:(RPGBattleStatus)aBattleStatus
                      reward:(RPGBattleReward *)aReward
                      status:(NSInteger)aStatus
                 currentTurn:(BOOL)aCurrentTurn
{
  return [self initWithHP:aHP
               opponentHP:anOpponentHP
          skillsCondition:aSkillsCondition
             skillsDamage:aSkillsDamage
             battleStatus:aBattleStatus
                   reward:aReward
                   status:aStatus
              currentTurn:aCurrentTurn];
}

@end
