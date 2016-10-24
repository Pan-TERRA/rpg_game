//
//  RPGBattleConditionResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

extern NSString * const kRPGBattleConditionResponseType;

@interface RPGBattleConditionResponse : RPGResponse

@property (nonatomic, assign, readonly) NSInteger HP;
@property (nonatomic, assign, readonly) NSInteger opponentHP;
@property (nonatomic, retain, readonly) NSDictionary *spellsCondition;
@property (nonatomic, retain, readonly) NSDictionary *reward;

#pragma mark - Init

- (instancetype)initWithHP:(NSInteger)aHP
                opponentHP:(NSInteger)anOpponentHP
           spellsCondition:(NSDictionary *)aSpellsCondition
                    reward:(NSDictionary *)aReward
                    status:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)battleConditionResponseWithHP:(NSInteger)aHP
                                   opponentHP:(NSInteger)anOpponentHP
                              spellsCondition:(NSDictionary *)aSpellsCondition
                                       reward:(NSDictionary *)aReward
                                       status:(NSInteger)aStatus;

@end
