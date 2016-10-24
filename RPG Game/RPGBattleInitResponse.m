
//  RPGBattleInitResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleInitResponse.h"
#import "RPGEntity.h"

NSString * const kRPGBattleInitResponseType = @"BATTLE_INIT";

@interface RPGBattleInitResponse ()

@property (nonatomic, retain, readwrite) RPGEntity *opponentInfo;
@property (nonatomic, assign, readwrite, getter=isCurrentTurn) BOOL currentTurn;
@property (nonatomic, assign, readwrite) NSInteger time;

@end

@implementation RPGBattleInitResponse

#pragma mark - Init

- (instancetype)initWithOpponentInfo:(RPGEntity *)anOpponentInfo
                         currentTurn:(BOOL)aCurrentTurn
                                time:(NSInteger)aTime
                              status:(NSInteger)aStatus
{
  self = [super initWithType:kRPGBattleInitResponseType
                      status:aStatus];
  
  if (self != nil)
  {
    if (anOpponentInfo == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _time = aTime;
      _opponentInfo = [anOpponentInfo retain];
      _currentTurn = aCurrentTurn;
    }
  }
  
  return self;
}

+ (instancetype)battleInitResponseWithOpponentInfo:(RPGEntity *)anOpponentInfo
                                       currentTurn:(BOOL)aCurrentTurn
                                              time:(NSInteger)aTime
                                            status:(NSInteger)aStatus
{
  return [[[RPGBattleInitResponse alloc] initWithOpponentInfo:anOpponentInfo
                                                  currentTurn:aCurrentTurn
                                                         time:aTime
                                                       status:aStatus] autorelease];
}

- (instancetype)initWithType:(NSString *)aType
                      status:(NSInteger)aStatus
{
  return [self initWithOpponentInfo:nil
                        currentTurn:0
                               time:0
                             status:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_opponentInfo release];
  [super dealloc];
}

@end
