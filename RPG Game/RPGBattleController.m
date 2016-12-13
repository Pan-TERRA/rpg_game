  //
  //  RPGBattleController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 11/13/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGBattleController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGRequest.h"
#import "RPGSkillActionRequest.h"
#import "RPGBattleInitResponse.h"
#import "RPGBattleConditionResponse.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"

  // Notifications
NSString * const kRPGModelDidChangeNotification = @"modelDidChangeNotification";
NSString * const kRPGBattleInitDidEndSetUpNotification =  @"battleInitDidEndNotification";
  // User info keys
NSString * const kRPGBattleControllerUserInfoErrorCodeKey = @"errorCode";

static NSString * const kRPGBattleControllerResponseType = @"type";

@interface RPGBattleController ()

@property (nonatomic, copy, readwrite) NSString *battleInitWebSocketMessageType;
@property (nonatomic, copy, readwrite) NSString *battleConditionWebSocketMessageType;

@property (copy, nonatomic, readwrite) void (^onBattleDismissCompletionHandler)(void);

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
  
}

#pragma mark - Misc

- (void)prepareBattleControllerForDismissWithCompletionHandler:(void (^)(void))callbackBlock
{
  [self prepareBattleControllerForDismiss];
  self.onBattleDismissCompletionHandler = callbackBlock;
}

- (void)prepareBattleControllerForDismiss
{

}

- (void)fireUpBattleController
{

}

- (void)requestBattleInit
{
  
}

- (void)dismissalDidFinish
{
  if (_onBattleDismissCompletionHandler != nil)
  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
      _onBattleDismissCompletionHandler();
    });
  }
}

@end
