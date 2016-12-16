//
//  RPGTournamentInitResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleInitResponse.h"
  // Constants
#import "RPGStatusCodes.h"

@interface RPGTournamentInitResponse : RPGBattleInitResponse

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
