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

- (void)sendBattleInitRequest
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  RPGRequest *request = [RPGRequest requestWithType:kRPGBattleInitMessageType
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
  RPGBattleInitResponse *battleInitResponse = nil;
  RPGBattleConditionResponse *battleConditionResponse = nil;
  
    // battle init
  if ([aResponse[kRPGBattleControllerResponseType] isEqualToString:kRPGBattleInitMessageType])
  {
    battleInitResponse = [[[RPGBattleInitResponse alloc] initWithDictionaryRepresentation:aResponse] autorelease];
    
    if (battleInitResponse != nil && battleInitResponse.status == 0)
    {
      self.battle = [RPGBattle battleWithBattleInitResponse:battleInitResponse];

      NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
      NSArray *skillsArray = [[standardUserDefaults.sessionCharacters firstObject] objectForKey:kRPGBattleControllerSkills];
      
      NSMutableArray *skills = [NSMutableArray array];
      for (NSNumber *skillID in skillsArray)
      {
        RPGSkill *skill = [[RPGSkill alloc] initWithSkillID:[skillID integerValue]];
        [skills addObject:skill];
        [skill release];
      }
      
      self.battle.player = [RPGPlayer playerWithSkills:skills];
      //self.battle.player = [RPGPlayer playerWithSkills:skillsArray];
      [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleInitDidEndSetUpNotification
                                                          object:self];
      [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification
                                                          object:self];
    }
  }
  
  
  if ([aResponse[kRPGBattleControllerResponseType] isEqualToString:kRPGBattleConditionMessageType])
  {
    battleConditionResponse = [[[RPGBattleConditionResponse alloc] initWithDictionaryRepresentation:aResponse] autorelease];
    
    if (battleConditionResponse != nil && battleConditionResponse.status == 0)
    {
      [self.battle updateWithBattleConditionResponse:battleConditionResponse];
      [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification object:self];
    }
  }
}

- (void)prepareBattleControllerForDismiss
{
  [self.websocketManager close];
}

@end
