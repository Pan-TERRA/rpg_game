  //
  //  RPGBattleController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 11/13/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGBattleController.h"
  // API
#import "RPGWebsocketManager.h"
#import "RPGNetworkManager+Skills.h"
  // Entities
#import "RPGBattleLog.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGResources.h"
#import "RPGRequest.h"
#import "RPGSkillActionRequest.h"
#import "RPGBattleInitResponse.h"
#import "RPGBattleConditionResponse.h"
#import "RPGSkill.h"
  // Misc
#import "RPGSerializable.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"

NSString * const kRPGModelDidChangeNotification = @"modelDidChangeNotification";
NSString * const kRPGBattleInitDidEndSetUpNotification =  @"battleInitDidEndNotification";

static NSString * const kRPGBattleControllerSkills = @"skills";
static NSString * const kRPGBattleControllerResponseType = @"type";

@interface RPGBattleController ()

@property (retain, nonatomic, readwrite) RPGBattle *battle;
@property (retain, nonatomic, readwrite) RPGWebsocketManager *websocketManager;

@end

@implementation RPGBattleController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    _websocketManager = [[RPGWebsocketManager alloc] initWithBattleController:self];
    [_websocketManager open];
    _battle = [[RPGBattle alloc] init];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battle release];
  [_websocketManager release];
  
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
  return [RPGRequest requestWithType:kRPGBattleInitMessageType
                               token:token];
}

- (void)sendBattleInitRequest
{
  RPGRequest *request = [self createBattleInitRequest];
  
  if (request != nil)
  {
    [self.websocketManager sendWebsocketManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}

- (void)sendSkillActionRequestWithSkillID:(NSInteger)aSkillID
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  RPGSkillActionRequest *request = [RPGSkillActionRequest requestWithSkillID:aSkillID
                                                                       token:token];
  
  if (request != nil)
  {
    [self.websocketManager sendWebsocketManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}

- (void)sendBattleConditionRequest
{
  
}

- (void)processManagerResponse:(NSDictionary *)aResponse
{
  if ([aResponse[kRPGBattleControllerResponseType] isEqualToString:kRPGBattleInitMessageType])
  {
    RPGBattleInitResponse *response = [[[RPGBattleInitResponse alloc]
                                        initWithDictionaryRepresentation:aResponse]
                                       autorelease];
    [self processBattleInitResponse:response];
  }
  else if ([aResponse[kRPGBattleControllerResponseType] isEqualToString:kRPGBattleConditionMessageType])
  {
    RPGBattleConditionResponse *response = [[[RPGBattleConditionResponse alloc]
                                             initWithDictionaryRepresentation:aResponse]
                                            autorelease];
    [self processBattleConditionResponse:response];
  }
}

- (void)processBattleInitResponse:(RPGBattleInitResponse *)aResponse
{
  if (aResponse != nil && aResponse.status == 0)
  {
    self.battle = [RPGBattle battleWithBattleInitResponse:aResponse];
    
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

- (void)processBattleConditionResponse:(RPGBattleConditionResponse *)aResponse
{
  if (aResponse != nil && aResponse.status == 0)
  {
    [self.battle updateWithBattleConditionResponse:aResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification object:self];
  }
}

- (void)prepareBattleControllerForDismiss
{
  [self.websocketManager close];
}

#pragma mark - Helper Methods

- (NSArray<NSNumber *> *)getPlayerSkillIDs
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSArray *skillIDs = [[standardUserDefaults.sessionCharacters firstObject] objectForKey:kRPGBattleControllerSkills];
  return skillIDs;
}

@end
