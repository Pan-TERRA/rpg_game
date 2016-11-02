//
//  RPGBattleManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleManager.h"
  // Entities
#import "RPGBattle.h"
#import "RPGSkill.h"
#import "RPGSkill+Serialization.h"
#import "RPGRequest+Serialization.h"
#import "RPGSkillActionRequest+Serialization.h"
#import "RPGTimeResponse+Serialization.h"
#import "RPGBattleInitResponse+Serialization.h"
#import "RPGBattleConditionResponse+Serialization.h"
#import "RPGBattleConditionResponse.h"
#import "RPGNetworkManager.h"
#import "RPGNetworkManager+Skills.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"
#import "RPGStatusCodes.h"

  // Notifications
NSString * const kRPGBattleManagerDidEndSetUpNotification = @"RPGBattleManagerDidEndSetUp";
NSString * const kRPGBattleManagerModelDidChangeNotification = @"RPGBattleManagerModelDidChange";

// TODO: replace to separate header file
static NSString * const kRPGBattleManagerAPI = @"ws://10.55.33.31:8888/ws";
static NSString * const kRPGBattleManagerResponseType = @"type";

typedef void (^fetchSkillsCompletionHandler)(NSInteger, NSArray *);

@interface RPGBattleManager () <SRWebSocketDelegate>

@property (retain, nonatomic, readwrite) RPGBattle *battle;
@property (copy, nonatomic, readwrite) NSString *token;



@end

@implementation RPGBattleManager

@synthesize delegate = _delegate;

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithURL:[NSURL URLWithString:kRPGBattleManagerAPI]];
  
  if (self != nil)
  {
    _delegate = self;
    _battle = [[RPGBattle alloc] init];
    _token = [[[NSUserDefaults standardUserDefaults] sessionToken] copy];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battle release];
  [_token release];

  [super dealloc];
}

#pragma mark - Actions

#pragma mark  Message Send

- (void)sendBattleInitRequest
{
  RPGRequest *request = [RPGRequest requestWithType:kRPGBattleInitMessageType token:self.token];
  
  if (request != nil)
  {
    [self sendBattleManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}

- (void)sendSkillActionRequestWithID:(NSInteger)anID
{
  
  RPGSkillActionRequest *request = [RPGSkillActionRequest requestWithSkillID:anID
                                                                       token:self.token];
  
  if (request != nil)
  {
    [self sendBattleManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}



- (void)sendBattleCondtionRequest
{
	
}

- (void)sendTimeSynchRequest
{
	
}

#pragma mark  API

- (void)sendBattleManagerMessageWithObject:(id<RPGSerializable>)anObject
{
    // logging
  NSLog(@"\r\nRequest:\r\n %@", [anObject dictionaryRepresentation]);
  
  NSError *JSONError = nil;
  NSData *data = [NSJSONSerialization dataWithJSONObject:[anObject dictionaryRepresentation]
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&JSONError];
  
  if (data == nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from skill actiion request"
                           userInfo:nil] raise];
  }
  else
  {
    [self send:data];
  }
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
   [self sendBattleInitRequest];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
  RPGBattleInitResponse *battleInitResponse = nil;
  RPGBattleConditionResponse *battleConditionResponse = nil;
  RPGTimeResponse *timeSynchResponse = nil;
  
  NSError *JSONError = nil;
  NSData *data = [(NSString *)message dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&JSONError];
  // TODO: Add status validation
  if (responseDictionary != nil)
  {
      // logging
    NSLog(@"\r\nResponse:\r\n %@", responseDictionary);
    
      // battle init
    if ([responseDictionary[kRPGBattleManagerResponseType] isEqualToString:kRPGBattleInitMessageType])
    {
      battleInitResponse = [[[RPGBattleInitResponse alloc] initWithDictionaryRepresentation:responseDictionary] autorelease];
      
      fetchSkillsCompletionHandler handler = ^void(NSInteger statusCode, NSArray *skills)
      {
        switch (statusCode)
        {
          case kRPGStatusCodeOk:
          {
            //Convert NSDictionary -> RPGSkill
            NSMutableArray *skillsArray = [NSMutableArray array];
            for (NSDictionary *skillDictionary in skills)
            {
              NSInteger skillID = [skillDictionary[@"skill_id"] integerValue];
              RPGSkill *skill = [RPGSkill skillWithSkillID:skillID];
              [skillsArray addObject:skill];
            }

            self.battle.player = [RPGPlayer playerWithSkills:skillsArray];
            break;
          }
          default:
          {
            NSLog(@"RPGBattleManager. Fetch skills unknown error");
            self.battle.player = [[RPGPlayer alloc] initWithSkills:[NSArray array]];
            break;
          }
        }
        // send notification to main menu
        [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleManagerModelDidChangeNotification
                                                            object:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleManagerDidEndSetUpNotification
                                                            object:self];
        
      };
      
      NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
      NSDictionary *character = nil;
      NSInteger characterID = -1;
      
      if ([[userDefaults.sessionCharacters firstObject] isKindOfClass:[NSDictionary class]])
      {
        character = (NSDictionary *)[userDefaults.sessionCharacters firstObject];
      }
      if (character)
      {
        characterID = [character[@"char_id"] integerValue];
      }
      
      [[RPGNetworkManager sharedNetworkManager] fetchSkillsByCharacterID:characterID completionHandler:handler];

    }
    
      // battle condition
    if ([responseDictionary[kRPGBattleManagerResponseType] isEqualToString:kRPGBattleConditionMessageType])
    {
      battleConditionResponse = [[[RPGBattleConditionResponse alloc] initWithDictionaryRepresentation:responseDictionary] autorelease];
    }
    
      // time response
    if ([responseDictionary[kRPGBattleManagerResponseType] isEqualToString:kRPGTimeResponseType])
    {
      timeSynchResponse = [[[RPGTimeResponse alloc] initWithDictionaryRepresentation:responseDictionary] autorelease];
    }
  }
  else
  {
      NSLog(@"JSON Error");
      NSLog(@"Domain: %@", JSONError.domain);
      NSLog(@"Error Code: %ld", (long)JSONError.code);
      NSLog(@"Description: %@", [JSONError localizedDescription]);
      NSLog(@"Reason: %@", [JSONError localizedFailureReason]);
  }

  // TODO: add error handling
  
    // battle init
  if (battleInitResponse != nil && battleInitResponse.status == 0)
  {
    self.battle = [RPGBattle battleWithBattleInitResponse:battleInitResponse];
   
  }
    // battle condition
  if (battleConditionResponse != nil && battleConditionResponse.status == 0)
  {
    [self.battle updateWithBattleConditionResponse:battleConditionResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleManagerModelDidChangeNotification object:self];
  }
  
    // time synch
  if (timeSynchResponse != nil && timeSynchResponse.status == 0)
  {
    [self.battle updateWithTimeSynchResponse:timeSynchResponse];
    // TODO: KVO support instead of notifications
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleManagerModelDidChangeNotification object:self];
  }
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(nullable NSString *)reason
         wasClean:(BOOL)wasClean
{
  
}

@end
