//
//  RPGArenaInitResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleInitResponse.h"

@interface RPGArenaInitResponse : RPGBattleInitResponse

- (instancetype)initWithOpponentInfo:(RPGEntity *)anOpponentInfo
                          playerInfo:(RPGPlayer *)aPlayerInfo
                         currentTurn:(BOOL)aCurrentTurn
                                time:(NSInteger)aTime
                              status:(RPGStatusCode)aStatus NS_DESIGNATED_INITIALIZER;

+ (instancetype)responseWithOpponentInfo:(RPGEntity *)anOpponentInfo
                              playerInfo:(RPGPlayer *)aPlayerInfo
                             currentTurn:(BOOL)aCurrentTurn
                                    time:(NSInteger)aTime
                                  status:(RPGStatusCode)aStatus;

@end
