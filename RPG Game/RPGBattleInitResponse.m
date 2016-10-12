
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
{
  self = [super initWithType:kRPGBattleInitResponseType];
  
  if (self != nil)
  {
    _mutableOpponentInfo = [anOpponentInfo mutableCopy];
    _currentTurn = aCurrentTurn;
  }
  
  return self;
}

+ (instancetype)battleInitResponseOpponentInfo:(NSDictionary *)anOpponentInfo
                         currentTurn:(BOOL)aCurrentTurn
{
  return [[[RPGBattleInitResponse alloc] initWithOpponentInfo:anOpponentInfo
                                                 currentTurn:aCurrentTurn] autorelease];
}


- (instancetype)init
{
  return nil;
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
