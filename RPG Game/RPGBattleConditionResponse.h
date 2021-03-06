  //
  //  RPGBattleConditionResponse.h
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGResponse.h"
  // Constants
#import "RPGBattleStatus.h"
  // Entities
@class RPGBattleReward;
@class RPGPlayerInfo;
  // Constants
#import "RPGStatusCodes.h"

@interface RPGBattleConditionResponse : RPGResponse

@property (nonatomic, retain, readonly) RPGPlayerInfo *playerInfo;
@property (nonatomic, retain, readonly) RPGPlayerInfo *opponentInfo;
@property (nonatomic, retain, readonly) NSArray<NSDictionary *> *skillsCondition;
@property (nonatomic, retain, readonly) NSDictionary *skillsDamage;
@property (nonatomic, retain, readonly) RPGBattleReward *reward;
@property (nonatomic, assign, readonly) RPGBattleStatus battleStatus;
@property (nonatomic, assign, readonly, getter=isCurrentTurn) BOOL currentTurn;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                  playerInfo:(RPGPlayerInfo *)aPlayerInfo
                opponentInfo:(RPGPlayerInfo *)anOpponentInfo
             skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                skillsDamage:(NSDictionary *)aSkillsDamage
                battleStatus:(RPGBattleStatus)aBattleStatus
                      reward:(RPGBattleReward *)aReward
                      status:(RPGStatusCode)aStatus
                 currentTurn:(BOOL)aCurrentTurn NS_DESIGNATED_INITIALIZER;
+ (instancetype)battleConditionResponseWithType:(NSString *)aType
                                     playerInfo:(RPGPlayerInfo *)aPlayerInfo
                                   opponentInfo:(RPGPlayerInfo *)anOpponentInfo
                                skillsCondition:(NSArray<NSDictionary *> *)aSkillsCondition
                                   skillsDamage:(NSDictionary *)aSkillsDamage
                                   battleStatus:(RPGBattleStatus)aBattleStatus
                                         reward:(RPGBattleReward *)aReward
                                         status:(RPGStatusCode)aStatus
                                    currentTurn:(BOOL)aCurrentTurn;

@end
