//
//  RPGAdventuresInitResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresInitResponse.h"
  // Constants
#import "RPGMessageTypes.h"

@implementation RPGAdventuresInitResponse

#pragma mark - Init

- (instancetype)initWithOpponentInfo:(RPGEntity *)anOpponentInfo
                          playerInfo:(RPGPlayer *)aPlayerInfo
                         currentTurn:(BOOL)aCurrentTurn
                                time:(NSInteger)aTime
                              status:(NSInteger)aStatus
{
  return [super initWithType:kRPGAdventuresInitMessageType
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
                      status:(NSInteger)aStatus
{
  return [self initWithOpponentInfo:anOpponentInfo
                         playerInfo:aPlayerInfo
                        currentTurn:aCurrentTurn
                               time:aTime
                             status:aStatus];
}

+ (instancetype)battleInitResponseWithOpponentInfo:(RPGEntity *)anOpponentInfo
                                        playerInfo:(RPGPlayer *)aPlayerInfo
                                       currentTurn:(BOOL)aCurrentTurn
                                              time:(NSInteger)aTime
                                            status:(NSInteger)aStatus
{
  return [[[self alloc] initWithOpponentInfo:anOpponentInfo
                                  playerInfo:aPlayerInfo
                                 currentTurn:aCurrentTurn
                                        time:aTime
                                      status:aStatus] autorelease];
}

@end
