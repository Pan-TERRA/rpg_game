//
//  RPGBattleInitResponse.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@class RPGEntity;

extern NSString * const kRPGBattleInitResponseType;

@interface RPGBattleInitResponse : RPGResponse

@property (nonatomic, retain, readonly) RPGEntity *opponentInfo;
@property (nonatomic, assign, readonly, getter=isCurrentTurn) BOOL currentTurn;
@property (nonatomic, assign, readonly) NSInteger time;


#pragma mark - Init

- (instancetype)initWithOpponentInfo:(RPGEntity *)anOpponentInfo
                         currentTurn:(BOOL)aCurrentTurn
                                time:(NSInteger)aTime
                              status:(NSInteger)aStatus NS_DESIGNATED_INITIALIZER;
+ (instancetype)battleInitResponseWithOpponentInfo:(RPGEntity *)anOpponentInfo
                                       currentTurn:(BOOL)aCurrentTurn
                                              time:(NSInteger)aTime
                                            status:(NSInteger)aStatus;

@end
