//
//  RPGArenaController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaController.h"
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
#import "RPGBattleInitResponse.h"
#import "RPGArenaInitRequest.h"
#import "RPGBattleConditionResponse.h"
  // Misc
#import "RPGSerializable.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"


static NSString * const kRPGWebsocketManagerAPIArenaBattle = @"ws://10.55.33.28:8888/arena_battle";

@interface RPGArenaController ()

@end

@implementation RPGArenaController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    _webSocketManager = [[RPGWebsocketManager alloc] initWithBattleController:self
                                                                          URL:[NSURL URLWithString:kRPGWebsocketManagerAPIArenaBattle]];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_webSocketManager release];
  
  [super dealloc];
}

#pragma mark - API

- (void)requestBattleInit
{
  [self sendBattleInitRequest];
}

- (RPGRequest *)createBattleInitRequest
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  return [RPGArenaInitRequest requestWithSkillIDs:self.skillsID token:token];
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

- (void)sendSkillActionRequestWithSkillID:(NSInteger)aSkillID
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  RPGSkillActionRequest *request = [RPGSkillActionRequest requestWithSkillID:aSkillID token:token];
  
  if (request != nil)
  {
    [self.webSocketManager sendWebsocketManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}

- (void)sendBattleConditionRequest
{
    // TODO: send after timeout
}

#pragma mark Process Manager Response

- (void)processManagerResponse:(NSDictionary *)aResponse
{
  [super processManagerResponse:aResponse];
}

- (void)processBattleInitResponse:(NSDictionary *)aResponse
{
  RPGBattleInitResponse *battleInitResponse = [[[RPGBattleInitResponse alloc]
                                                initWithDictionaryRepresentation:aResponse]
                                               autorelease];
  
  if (battleInitResponse != nil && battleInitResponse.status == 0)
  {
    self.battle = [RPGBattle battleWithBattleInitResponse:battleInitResponse];
    
    NSArray<NSNumber *> *skillIDs = [self getPlayerSkillIDs];
    
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

- (void)processBattleConditionResponse:(NSDictionary *)aResponse
{
  RPGBattleConditionResponse *battleConditionResponse = [[[RPGBattleConditionResponse alloc]
                                                          initWithDictionaryRepresentation:aResponse] autorelease];
  
  if (battleConditionResponse != nil && battleConditionResponse.status == 0)
  {
    [self.battle updateWithBattleConditionResponse:battleConditionResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification object:self];
  }
}

#pragma mark - Helper Methods

// TODO: maybe pass skillIDs not with RPGArenaController, but using NSUserDefaults (default
// behavior for RPGBattleController)
- (NSArray<NSNumber *> *)getPlayerSkillIDs
{
  return self.skillsID;
}

@end
