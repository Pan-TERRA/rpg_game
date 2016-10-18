//
//  RPGBattleInitResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@interface RPGBattleInitResponse : RPGResponse

@property (retain, nonatomic, readonly) NSDictionary *opponentInfo;
@property (nonatomic, readonly, getter=isCurrentTurn) BOOL currentTurn;

#pragma mark - Init

- (instancetype)initWithOpponentInfo:(NSDictionary *)anOpponentInfo
                         currentTurn:(BOOL)aCurrentTurn;
+ (instancetype)battleInitResponseWithOpponentInfo:(NSDictionary *)anOpponentInfo
                         currentTurn:(BOOL)aCurrentTurn;


@end
