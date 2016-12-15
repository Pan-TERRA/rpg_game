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
  // Entities
#import "RPGBattle.h"
#import "RPGRequest.h"
#import "RPGSkillActionRequest.h"
#import "RPGBattleInitResponse.h"
#import "RPGBattleConditionResponse.h"
  // Constants
#import "RPGMessageTypes.h"

  // Notifications
NSString * const kRPGModelDidChangeNotification = @"modelDidChangeNotification";
NSString * const kRPGBattleInitDidEndSetUpNotification =  @"battleInitDidEndNotification";
  // User info keys
NSString * const kRPGBattleControllerUserInfoErrorCodeKey = @"errorCode";

static NSString * const kRPGBattleControllerResponseType = @"type";

@interface RPGBattleController ()

@property (nonatomic, retain, readwrite) RPGWebsocketManager *webSocketManager;

@property (nonatomic, copy, readwrite) NSString *battleInitWebSocketMessageType;
@property (nonatomic, copy, readwrite) NSString *battleConditionWebSocketMessageType;

@property (nonatomic, copy, readwrite) void (^onBattleDismissCompletionHandler)(void);

@end

@implementation RPGBattleController

#pragma mark - Init

- (instancetype)init
{
  return [self initWithWebSocketManager:[[[RPGWebsocketManager alloc] init] autorelease]];
}

- (instancetype)initWithWebSocketManager:(RPGWebsocketManager *)aManager
{
  self = [super init];
  
  if (self != nil)
  {
    _battle = [[RPGBattle alloc] init];
    _battleInitWebSocketMessageType = nil;
    _battleConditionWebSocketMessageType = nil;
    _webSocketManager = [aManager retain];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battle release];
  [_battleConditionWebSocketMessageType release];
  [_battleInitWebSocketMessageType release];
  [_webSocketManager release];
  [_onBattleDismissCompletionHandler release];
  
  [super dealloc];
}

#pragma mark - Creating Request

- (RPGRequest *)createBattleInitRequest
{
  return nil;
}

- (RPGRequest *)createBattleConditionRequest
{
  return nil;
}

#pragma mark  - Process Manager Response

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

#pragma mark Battle Init Response

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

#pragma mark Battle Condition Response

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

#pragma mark - Misc

- (void)prepareBattleControllerForDismissWithCompletionHandler:(void (^)(void))callbackBlock
{
  [self prepareBattleControllerForDismiss];
  self.onBattleDismissCompletionHandler = callbackBlock;
}

- (void)prepareBattleControllerForDismiss
{
  [self.webSocketManager close];
}

- (void)fireUpBattleController
{
  [self.webSocketManager open];
}

- (void)requestBattleInit
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

- (void)dismissalDidFinish
{
  if (self.onBattleDismissCompletionHandler != nil)
  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
      _onBattleDismissCompletionHandler();
    });
  }
}

@end
