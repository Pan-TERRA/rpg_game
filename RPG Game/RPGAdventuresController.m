//
//  RPGAdventuresController.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresController.h"
  // API
#import "RPGWebsocketManager.h"
#import "RPGNetworkManager+Skills.h"
  // Entities
#import "RPGBattleLog.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGSkill.h"
#import "RPGResources.h"
#import "RPGRequest.h"
#import "RPGSkillActionRequest.h"
#import "RPGAdventuresInitResponse.h"
#import "RPGAdventuresConditionResponse.h"
  // Misc
#import "RPGSerializable.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"
#import "RPGUserSessionKeys.h"

@interface RPGAdventuresController ()

@property (retain, nonatomic, readwrite) RPGWebsocketManager *webSocketManager;

@end

@implementation RPGAdventuresController

#pragma mark - Init

- (instancetype)initWithWebSocketManager:(RPGWebsocketManager *)aManager
{
  self = [super init];
  
  if (self != nil)
  {
    _webSocketManager = [aManager retain];
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithWebSocketManager:[[[RPGWebsocketManager alloc] init] autorelease]];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_webSocketManager release];
  
  [super dealloc];
}

#pragma mark - Creating Request

- (RPGRequest *)createBattleInitRequest
{
  return [RPGRequest requestWithType:kRPGAdventuresInitMessageType];
}

#pragma mark - Process Manager Response

- (void)processManagerResponse:(NSDictionary *)aResponse
{
  [super processManagerResponse:aResponse];
}

#pragma mark - Battle Init Response

- (void)processBattleInitResponse:(NSDictionary *)aResponse
{
  RPGAdventuresInitResponse *battleInitResponse = [[[RPGAdventuresInitResponse alloc]
                                                initWithDictionaryRepresentation:aResponse]
                                               autorelease];
  
  if (battleInitResponse != nil && battleInitResponse.status == 0)
  {
    self.battle = [RPGBattle battleWithBattleInitResponse:battleInitResponse];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *skillIDs = standardUserDefaults.sessionCharacters.firstObject[kRPGUserSessionKeyCharacterSkills];
    
    NSMutableArray *skills = [NSMutableArray array];
    for (NSNumber *skillID in skillIDs)
    {
      RPGSkill *skill = [[RPGSkill alloc] initWithSkillID:[skillID integerValue]];
      [skills addObject:skill];
      [skill release];
    }
    self.battle.player.skills = skills;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleInitDidEndSetUpNotification
                                                        object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification
                                                        object:self];
  }
}

#pragma mark - Battle Condition Response

- (void)processBattleConditionResponse:(NSDictionary *)aResponse
{
  RPGAdventuresConditionResponse *battleConditionResponse = [[[RPGAdventuresConditionResponse alloc]
                                                          initWithDictionaryRepresentation:aResponse] autorelease];
  
  if (battleConditionResponse != nil && battleConditionResponse.status == 0)
  {
    [self.battle updateWithBattleConditionResponse:battleConditionResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification object:self];
  }
}

#pragma mark - Actions


- (void)sendSkillActionRequestWithSkillID:(NSInteger)aSkillID
{
  RPGSkillActionRequest *request = [RPGSkillActionRequest requestWithSkillID:aSkillID];
  
  if (request != nil)
  {
    [self.webSocketManager sendWebsocketManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}

- (void)sendBattleInitRequest
{
  id request = [self createBattleInitRequest];
  
  if (request != nil)
  {
    [self.webSocketManager sendWebsocketManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}

#pragma mark - Misc

- (void)prepareBattleControllerForDismiss
{
  [self.webSocketManager close];
}

- (void)openBattleControllerWebSocket
{
  [self.webSocketManager open];
}

- (void)requestBattleInit
{
  [self sendBattleInitRequest];
}

@end
