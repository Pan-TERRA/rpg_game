//
//  RPGBattleConditionResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@class RPGResources;

@interface RPGBattleConditionResponse : RPGResponse

@property (nonatomic, assign, readonly) NSInteger HP;
@property (nonatomic, assign, readonly) NSInteger opponentHP;
@property (nonatomic, retain, readonly) NSArray *skillsCondition;
@property (nonatomic, retain, readonly) NSDictionary *skillsDamage;
@property (nonatomic, retain, readonly) RPGResources *reward;
@property (nonatomic, assign, readonly, getter=isCurrentTurn) BOOL currentTurn;

#pragma mark - Init

- (instancetype)initWithHP:(NSInteger)aHP
                opponentHP:(NSInteger)anOpponentHP
           skillsCondition:(NSArray *)aSkillsCondition
              skillsDamage:(NSDictionary *)aSkillsDamage
                    reward:(RPGResources *)aReward
                    status:(NSInteger)aStatus
               currentTurn:(BOOL)aCurrentTurn NS_DESIGNATED_INITIALIZER;
+ (instancetype)battleConditionResponseWithHP:(NSInteger)aHP
                                   opponentHP:(NSInteger)anOpponentHP
                              skillsCondition:(NSArray *)aSkillsCondition
                                 skillsDamage:(NSDictionary *)aSkillsDamage
                                       reward:(RPGResources *)aReward
                                       status:(NSInteger)aStatus
                                  currentTurn:(BOOL)aCurrentTurn;

@end
