//
//  RPGBattleConditionResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@interface RPGBattleConditionResponse : RPGResponse

@property (nonatomic, readonly) int HP;
@property (nonatomic, readonly) int opponentHP;
@property (retain, nonatomic, readonly) NSDictionary *spellsCondition;
@property (retain, nonatomic, readonly) NSDictionary *reward;

#pragma mark - Init

- (instancetype)initWithHP:(int)aHP
                opponentHP:(int)anOpponentHP
           spellsCondition:(NSDictionary *)aSpellsCondition
                    reward:(NSDictionary *)aReward NS_DESIGNATED_INITIALIZER;


+ (instancetype)battleConditionResponseWithHP:(int)aHP
                opponentHP:(int)anOpponentHP
           spellsCondition:(NSDictionary *)aSpellsCondition
                    reward:(NSDictionary *)aReward;

@end
