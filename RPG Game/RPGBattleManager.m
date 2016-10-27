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
#import "RPGRequest+Serialization.h"
#import "RPGSkillActionRequest.h"
#import "RPGTimeResponse+Serialization.h"
#import "RPGBattleInitResponse+Serialization.h"
#import "RPGBattleConditionResponse+Serialization.h"
#import "RPGBattleConditionResponse.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"

NSString * const kRPBBattleManagerModelDidChangeNotification = @"RPGBattleManagerModelDidChange";
static NSString * const kRPGBattleManagerAPI = @"ws://10.55.33.31:8888/ws";
static NSString * const kRPGBattleManagerResponseType = @"type";

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
//    _battle = [[RPGBattle alloc] init];
    _token = [[[NSUserDefaults standardUserDefaults] sessionToken] retain];
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

- (void)sendBattleInitRequest
{
  NSError *JSONError = nil;
  RPGRequest *request = [RPGRequest requestWithType:kRPGBattleInitResponseType token:self.token];
  
  if (request != nil)
  {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[request dictionaryRepresentation]
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&JSONError];
    
    if (data == nil)
    {
      [[NSException exceptionWithName:NSInvalidArgumentException
                               reason:@"JSON cannot be retrieved from battle init request"
                             userInfo:nil] raise];
    }
    else
    {
      [self send:data];
    }
  }
}

- (void)sendSkillActionRequestWithID:(NSInteger)anID
{
  NSError *JSONError = nil;
  RPGSkillActionRequest *request = [RPGSkillActionRequest requestWithSkillID:anID
                                                                       token:self.token];
  
  if (request != nil)
  {
    NSData *data = [NSJSONSerialization dataWithJSONObject:[request dictionaryRepresentation]
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
}

- (void)sendBattleCondtionRequest
{
	
}

- (void)sendTimeSynchRequest
{
	
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
      // battle init
    if ([responseDictionary[kRPGBattleManagerResponseType] isEqualToString:kRPGBattleInitResponseType])
    {
      battleInitResponse = [[[RPGBattleInitResponse alloc] initWithDictionaryRepresentation:responseDictionary] autorelease];
    }
    
      // battle condition
    if ([responseDictionary[kRPGBattleManagerResponseType] isEqualToString:kRPGBattleConditionResponseType])
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
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPBBattleManagerModelDidChangeNotification object:self];
  }
    // battle condition
  if (battleConditionResponse != nil && battleConditionResponse.status == 0)
  {
    [self.battle updateWithBattleConditionResponse:battleConditionResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPBBattleManagerModelDidChangeNotification object:self];
  }
  
    // time synch
  if (timeSynchResponse != nil && timeSynchResponse.status == 0)
  {
    [self.battle updateWithTimeSynchResponse:timeSynchResponse];
    // TODO: KVO support instead of notifications
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPBBattleManagerModelDidChangeNotification object:self];
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
