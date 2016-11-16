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
#import "RPGSkillsRequest.h"
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

static NSString * const kRPGBattleControllerCharacterID = @"char_id";
static NSString * const kRPGBattleControllerSkillID = @"skill_id";
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

#pragma mark - Accessors

#pragma mark  Player

- (NSString *)playerNickName
{
  return self.battle.player.name;
}

- (NSInteger)playerHP
{
  return self.battle.player.HP;
}

- (BOOL)isMyTurn
{
  return self.battle.isCurrentTurn;
}

- (NSUInteger)skillsCount
{
  return self.battle.player.skills.count;
}

- (NSArray *)skillsID
{
  return self.battle.player.skills;
}

#pragma mark  Opponent

- (NSString *)opponentNickName
{
  return self.battle.opponent.name;
}

- (NSInteger)opponentHP
{
  return self.battle.opponent.HP;
}

#pragma mark  General

- (NSInteger)rewardGold
{
  return self.battle.reward.gold;
}

- (NSArray *)actions
{
  return self.battle.battleLog.actions;
}

- (NSString *)attackerNickName
{
  return self.myTurn ? self.playerNickName : self.opponentNickName;
}

- (NSString *)defenderNickName
{
  return !self.myTurn ? self.playerNickName : self.opponentNickName;
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

- (void)sendSkillActionRequestWithTag:(NSInteger)aTag
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  NSArray *skills = self.battle.player.skills;
  NSInteger index = aTag - 1;
  RPGSkillActionRequest *request = nil;
  NSInteger skillID = [[[skills[index] allKeys] firstObject] integerValue];
  
  request = [RPGSkillActionRequest requestWithSkillID:skillID
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
      
        // fetching skills
      NSInteger characterID = [self getCharacterID];
      [[RPGNetworkManager sharedNetworkManager] fetchSkillsByCharacterID:characterID completionHandler:
       ^void(NSInteger statusCode, NSArray *skills)
       {
           // invokes on main thread
         switch (statusCode)
         {
           case kRPGStatusCodeOK:
           {
             NSArray *skillsArray = [self convertSkillsFromArray:skills];
             self.battle.player = [RPGPlayer playerWithSkills:skillsArray];
             break;
           }
             
           default:
           {
             NSLog(@"RPGBattleController. Fetch skills unknown error");
             self.battle.player = [RPGPlayer playerWithSkills:[NSArray array]];
             break;
           }
         }
         
           // send notification to battle view controller
         [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleInitDidEndSetUpNotification
                                                             object:self];
         [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification
                                                             object:self];
       }];
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

#pragma mark - Helper Methods

- (NSInteger)getCharacterID
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSDictionary *character = nil;
  NSInteger characterID = -1;
  
  if ([[userDefaults.sessionCharacters firstObject] isKindOfClass:[NSDictionary class]])
  {
    character = (NSDictionary *)[userDefaults.sessionCharacters firstObject];
  }
  if (character)
  {
    characterID = [character[kRPGBattleControllerCharacterID] integerValue];
  }
  
  return characterID;
}

- (NSArray *)convertSkillsFromArray:(NSArray *)anArray
{
  NSMutableArray<NSNumber *> *skillsArray = [NSMutableArray array];
  
  for (NSDictionary *skillDictionary in anArray)
  {
    [skillsArray addObject:skillDictionary[kRPGBattleControllerSkillID]];
  }
  
  return skillsArray;
}

@end
