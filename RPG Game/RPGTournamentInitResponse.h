//
//  RPGTournamentInitResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleInitResponse.h"

@interface RPGTournamentInitResponse : RPGBattleInitResponse

- (instancetype)initWithOpponentInfo:(RPGEntity *)anOpponentInfo
                          playerInfo:(RPGPlayer *)aPlayerInfo
                         currentTurn:(BOOL)aCurrentTurn
                                time:(NSInteger)aTime
                              status:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;

+ (instancetype)responseWithOpponentInfo:(RPGEntity *)anOpponentInfo
                              playerInfo:(RPGPlayer *)aPlayerInfo
                             currentTurn:(BOOL)aCurrentTurn
                                    time:(NSInteger)aTime
                                  status:(NSInteger)aStatus;

@end
