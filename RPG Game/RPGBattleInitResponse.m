
  //  RPGBattleInitResponse.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGBattleInitResponse.h"
  // Entities
#import "RPGPlayer.h"
  // Constants
#import "RPGMessageTypes.h"

static NSString * const kRPGBattleInitResponseOpponentInfo = @"opponent_info";
static NSString * const kRPGBattleInitResponsePlayerInfo = @"player_info";
static NSString * const kRPGBattleInitResponseOpponentTime = @"time";
static NSString * const kRPGBattleInitResponseCurrentTurn = @"is_current_turn";

@interface RPGBattleInitResponse ()

@property (nonatomic, retain, readwrite) RPGPlayer *playerInfo;
@property (nonatomic, retain, readwrite) RPGEntity *opponentInfo;
@property (nonatomic, assign, readwrite, getter=isCurrentTurn) BOOL currentTurn;
@property (nonatomic, assign, readwrite) NSInteger time;

@end

@implementation RPGBattleInitResponse

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                opponentInfo:(RPGEntity *)anOpponentInfo
                  playerInfo:(RPGPlayer *)aPlayerInfo
                 currentTurn:(BOOL)aCurrentTurn
                        time:(NSInteger)aTime
                      status:(RPGStatusCode)aStatus
{
  self = [super initWithType:aType
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
      _playerInfo = [aPlayerInfo retain];
      _opponentInfo = [anOpponentInfo retain];
      _currentTurn = aCurrentTurn;
    }
  }
  
  return self;
}

+ (instancetype)battleInitResponseWithType:(NSString *)aType
                              opponentInfo:(RPGEntity *)anOpponentInfo
                                playerInfo:(RPGPlayer *)aPlayerInfo
                               currentTurn:(BOOL)aCurrentTurn
                                      time:(NSInteger)aTime
                                    status:(RPGStatusCode)aStatus
{
  return [[[RPGBattleInitResponse alloc] initWithType:aType
                                         opponentInfo:anOpponentInfo
                                           playerInfo:aPlayerInfo
                                          currentTurn:aCurrentTurn
                                                 time:aTime
                                               status:aStatus] autorelease];
}

- (instancetype)initWithType:(NSString *)aType
                      status:(RPGStatusCode)aStatus
{
  return [self initWithType:nil
               opponentInfo:nil
                 playerInfo:nil
                currentTurn:NO
                       time:0
                     status:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_opponentInfo release];
  [_playerInfo release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  if (self.playerInfo != nil)
  {
    dictionaryRepresentation[kRPGBattleInitResponsePlayerInfo] = [self.playerInfo dictionaryRepresentation];
  }
  if (self.opponentInfo != nil)
  {
    dictionaryRepresentation[kRPGBattleInitResponseOpponentInfo] = [self.opponentInfo dictionaryRepresentation];
  }
  dictionaryRepresentation[kRPGBattleInitResponseCurrentTurn] = [NSNumber numberWithBool:self.isCurrentTurn];
  dictionaryRepresentation[kRPGBattleInitResponseOpponentTime] = @(self.time);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGEntity *opponentInfo = [[[RPGEntity alloc] initWithDictionaryRepresentation:aDictionary[kRPGBattleInitResponseOpponentInfo]] autorelease];
  RPGPlayer *playerInfo = [[[RPGPlayer alloc] initWithDictionaryRepresentation:aDictionary[kRPGBattleInitResponsePlayerInfo]] autorelease];
  
  return [self initWithType:aDictionary[kRPGResponseSerializationType]
               opponentInfo:opponentInfo
                 playerInfo:playerInfo
                currentTurn:[aDictionary[kRPGBattleInitResponseCurrentTurn] boolValue]
                       time:[aDictionary[kRPGBattleInitResponseOpponentTime] integerValue]
                     status:[aDictionary[kRPGResponseSerializationStatus] integerValue]];
}


@end
