//
//  RPGAdventuresInitResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleInitResponse.h"

@interface RPGAdventuresInitResponse : RPGBattleInitResponse

- (instancetype)initWithOpponentInfo:(RPGEntity *)anOpponentInfo
                  playerInfo:(RPGPlayer *)aPlayerInfo
                 currentTurn:(BOOL)aCurrentTurn
                        time:(NSInteger)aTime
                      status:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;

+ (instancetype)battleInitResponseWithOpponentInfo:(RPGEntity *)anOpponentInfo
                                playerInfo:(RPGPlayer *)aPlayerInfo
                               currentTurn:(BOOL)aCurrentTurn
                                      time:(NSInteger)aTime
                                    status:(NSInteger)aStatus;

@end
