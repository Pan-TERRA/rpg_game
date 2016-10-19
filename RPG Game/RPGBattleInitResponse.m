
//  RPGBattleInitResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleInitResponse.h"

static NSString *const kRPGBattleInitResponseType = @"BATTLE_INIT";

@interface RPGBattleInitResponse ()

@property (retain, nonatomic, readwrite) NSMutableDictionary *mutableOpponentInfo;
@property (nonatomic, readwrite, getter=isCurrentTurn) BOOL currentTurn;

@end

@implementation RPGBattleInitResponse

@synthesize mutableOpponentInfo = _mutableOpponentInfo;
@synthesize currentTurn = _currentTurn;

#pragma mark - Init

- (instancetype)initWithOpponentInfo:(NSDictionary *)anOpponentInfo
                         currentTurn:(BOOL)aCurrentTurn
                              status:(NSInteger)aStatus
{
  self = [super initWithType:kRPGBattleInitResponseType status:aStatus];
  
  
  
  if (self != nil)
  {
    if (anOpponentInfo == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _mutableOpponentInfo = [anOpponentInfo mutableCopy];
      _currentTurn = aCurrentTurn;
    }
  }
  
  return self;
}

+ (instancetype)battleInitResponseWithOpponentInfo:(NSDictionary *)anOpponentInfo
                                       currentTurn:(BOOL)aCurrentTurn
                                            status:(NSInteger)aStatus
{
  return [[[RPGBattleInitResponse alloc] initWithOpponentInfo:anOpponentInfo
                                                  currentTurn:aCurrentTurn
                                                       status:aStatus] autorelease];
}


- (instancetype)initWithType:(NSString *)aType status:(NSInteger)aStatus
{
  return [self initWithOpponentInfo:nil currentTurn:0 status:-1];
}

+ (instancetype)battleInitResponse
{
  return nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_mutableOpponentInfo release];
  
  [super dealloc];
}

@end
