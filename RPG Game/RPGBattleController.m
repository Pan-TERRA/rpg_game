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
#import "RPGBattle.h"
#import "RPGRequest.h"
#import "RPGSkillsRequest.h"
#import "RPGSkillActionRequest.h"
#import "RPGResources.h"

#import "RPGBattleInitResponse.h"
#import "RPGBattleConditionResponse.h"
  // Misc
#import "RPGSerializable.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"

NSString * const kRPGModelDidChangeNotification = @"modelDidChangeNotification";
NSString * const kRPGBattleInitDidEndSetUpNotification =  @"battleInitDidEndNotification";

static NSString * const kRPGResponseType = @"type";

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
  
  request = [RPGSkillActionRequest requestWithSkillID:[skills[index] integerValue]
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
  if ([aResponse[kRPGResponseType] isEqualToString:kRPGBattleInitMessageType])
  {
    battleInitResponse = [[[RPGBattleInitResponse alloc] initWithDictionaryRepresentation:aResponse] autorelease];
    
    if (battleInitResponse != nil && battleInitResponse.status == 0)
    {
      self.battle = [RPGBattle battleWithBattleInitResponse:battleInitResponse];
        // getting char id
      NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
      NSDictionary *character = nil;
      NSInteger characterID = -1;
      
      if ([[userDefaults.sessionCharacters firstObject] isKindOfClass:[NSDictionary class]])
      {
        character = (NSDictionary *)[userDefaults.sessionCharacters firstObject];
      }
      if (character)
      {
          //TODO: remove hardcode
        characterID = [character[@"char_id"] integerValue];
      }
      
      [[RPGNetworkManager sharedNetworkManager] fetchSkillsByCharacterID:characterID completionHandler:
       ^void(NSInteger statusCode, NSArray *skills)
       {
           // invokes on main thread
         switch (statusCode)
         {
           case kRPGStatusCodeOK:
           {
               //Convert NSDictionary -> RPGSkill
             NSMutableArray<NSNumber *> *skillsArray = [NSMutableArray array];
             for (NSDictionary *skillDictionary in skills)
             {
                 //TODO: remove hardcode
               [skillsArray addObject:skillDictionary[@"skill_id"]];
             }
             
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
  
  
  if ([aResponse[kRPGResponseType] isEqualToString:kRPGBattleConditionMessageType])
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
