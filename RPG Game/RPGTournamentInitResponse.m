//
//  RPGTournamentInitResponse.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentInitResponse.h"
  // Constants
#import "RPGMessageTypes.h"

@implementation RPGTournamentInitResponse

#pragma mark - Init

- (instancetype)initWithOpponentInfo:(RPGEntity *)anOpponentInfo
                          playerInfo:(RPGPlayer *)aPlayerInfo
                         currentTurn:(BOOL)aCurrentTurn
                                time:(NSInteger)aTime
                              status:(RPGStatusCode)aStatus
{
  return [super initWithType:kRPGTournamentInitMessageType
                opponentInfo:anOpponentInfo
                  playerInfo:aPlayerInfo
                 currentTurn:aCurrentTurn
                        time:aTime
                      status:aStatus];
}

- (instancetype)initWithType:(NSString *)aType
                opponentInfo:(RPGEntity *)anOpponentInfo
                  playerInfo:(RPGPlayer *)aPlayerInfo
                 currentTurn:(BOOL)aCurrentTurn
                        time:(NSInteger)aTime
                      status:(RPGStatusCode)aStatus
{
  return [self initWithOpponentInfo:anOpponentInfo
                         playerInfo:aPlayerInfo
                        currentTurn:aCurrentTurn
                               time:aTime
                             status:aStatus];
}

+ (instancetype)responseWithOpponentInfo:(RPGEntity *)anOpponentInfo
                              playerInfo:(RPGPlayer *)aPlayerInfo
                             currentTurn:(BOOL)aCurrentTurn
                                    time:(NSInteger)aTime
                                  status:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithOpponentInfo:anOpponentInfo
                                  playerInfo:aPlayerInfo
                                 currentTurn:aCurrentTurn
                                        time:aTime
                                      status:aStatus] autorelease];
}

@end
