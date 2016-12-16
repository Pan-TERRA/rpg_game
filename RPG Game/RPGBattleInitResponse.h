  //
  //  RPGBattleInitResponse.h
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGResponse.h"
  // Entities
@class RPGEntity;
@class RPGPlayer;

@interface RPGBattleInitResponse : RPGResponse

@property (nonatomic, retain, readonly) RPGPlayer *playerInfo;
@property (nonatomic, retain, readonly) RPGEntity *opponentInfo;
@property (nonatomic, assign, readonly, getter=isCurrentTurn) BOOL currentTurn;
@property (nonatomic, assign, readonly) NSInteger time;


#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                opponentInfo:(RPGEntity *)anOpponentInfo
                  playerInfo:(RPGPlayer *)aPlayerInfo
                 currentTurn:(BOOL)aCurrentTurn
                        time:(NSInteger)aTime
                      status:(RPGStatusCode)aStatus NS_DESIGNATED_INITIALIZER;

+ (instancetype)battleInitResponseWithType:(NSString *)aType
                              opponentInfo:(RPGEntity *)anOpponentInfo
                                playerInfo:(RPGPlayer *)aPlayerInfo
                               currentTurn:(BOOL)aCurrentTurn
                                      time:(NSInteger)aTime
                                    status:(RPGStatusCode)aStatus;

@end
