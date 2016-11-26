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
#import "RPGSkill.h"
#import "RPGResources.h"
#import "RPGRequest.h"
#import "RPGSkillActionRequest.h"
#import "RPGBattleInitResponse.h"
#import "RPGBattleConditionResponse.h"
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

@property (copy, nonatomic, readwrite) NSString *battleInitWebSocketMessageType;
@property (copy, nonatomic, readwrite) NSString *battleConditionWebSocketMessageType;

@end

@implementation RPGBattleController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    _battle = [[RPGBattle alloc] init];
    _battleInitWebSocketMessageType = nil;
    _battleConditionWebSocketMessageType = nil;
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battle release];
  [_battleConditionWebSocketMessageType release];
  [_battleInitWebSocketMessageType release];
  
  [super dealloc];
}

#pragma mark - API

- (void)requestBattleInit
{
  
}

- (RPGRequest *)createBattleInitRequest
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  return [RPGRequest requestWithType:kRPGBattleInitMessageType
                               token:token];
}

- (void)sendBattleInitRequest
{

}

- (void)sendSkillActionRequestWithSkillID:(NSInteger)aSkillID
{

}

- (void)sendBattleConditionRequest
{
  // TODO: send after timeout
}

#pragma mark Process Manager Response

- (void)processManagerResponse:(NSDictionary *)aResponse
{
  NSString *responseMessageType = aResponse[kRPGBattleControllerResponseType];
  
  if ([responseMessageType isEqualToString:self.battleInitWebSocketMessageType])
  {
    [self processBattleInitResponse:aResponse];
  }
  else if ([responseMessageType isEqualToString:self.battleConditionWebSocketMessageType])
  {
    [self processBattleConditionResponse:aResponse];
  }
}

- (void)registerWebSocketMessageTypeForBattleInitResponse:(NSString *)aMessageType
{
  if (aMessageType != nil)
  {
    self.battleInitWebSocketMessageType = aMessageType;
  }
}

- (void)processBattleInitResponse:(NSDictionary *)aResponse
{

}

- (void)registerWebSocketMessageTypeForBattleConditionResponse:(NSString *)aMessageType
{
  if (aMessageType != nil)
  {
    self.battleConditionWebSocketMessageType = aMessageType;
  }
}

- (void)processBattleConditionResponse:(NSDictionary *)aResponse
{

}

- (void)prepareBattleControllerForDismiss
{

}

- (void)openBattleControllerWebSocket
{

}

#pragma mark - Helper Methods

- (NSArray<NSNumber *> *)getPlayerSkillIDs
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSArray *skillIDs = [[standardUserDefaults.sessionCharacters firstObject] objectForKey:kRPGBattleControllerSkills];
  return skillIDs;
}



@end
