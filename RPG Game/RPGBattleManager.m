//
//  RPGBattleManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleManager.h"
  // Entities
#import "RPGRequest+Serialization.h"
#import "RPGBattleInitResponse+Serialization.h"
//#import "RPGBattleConditionResponse+Serialization.h"
#import "RPGBattleConditionResponse.h"
//#import "RPGSpellActionRequest.h"
//#import "RPGSpellActionResponse+Serialization.h"
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

- (void)sendSpellActionRequestWithID:(NSInteger)anID
{
    // future
  
//  NSError *JSONError = nil;
//  RPGSpellActionRequest *request = [[RPGRequest alloc] initWithType:kRPGSpellActionResponseType token:self.token];
//  
//  if (request != nil)
//  {
//    NSData *data = [NSJSONSerialization dataWithJSONObject:[request dictionaryRepresentation]
//                                                   options:NSJSONWritingPrettyPrinted
//                                                     error:&JSONError];
//    
//    if (data == nil)
//    {
//      [[NSException exceptionWithName:NSInvalidArgumentException
//                               reason:@"JSON cannot be retrieved from spell actiion request"
//                             userInfo:nil] raise];
//    }
//    else
//    {
//      [self send:data];
//    }
//  }
}

- (void)sendBattleCondtionRequest
{
	
}

- (void)sendTimeSynchRequest
{
	
}

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

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
  [self sendBattleInitRequest];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
  RPGBattleInitResponse *battleInitResponse = nil;
  RPGBattleConditionResponse *battleConditionResponse = nil;
  NSError *JSONError = nil;
  NSData *data = [(NSString *)message dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&JSONError];
  if (responseDictionary != nil)
  {
    if ([responseDictionary[kRPGBattleManagerResponseType] isEqualToString:kRPGBattleInitResponseType])
    {
      battleInitResponse = [[RPGBattleInitResponse alloc] initWithDictionaryRepresentation:responseDictionary];
    }
    
    if ([responseDictionary[kRPGBattleManagerResponseType] isEqualToString:kRPGBattleConditionResponseType])
    {
//      battleConditionResponse = [[RPGBattleConditionResponse alloc] initWithDictionaryRepresentation:responseDictionary];
    }
  }
  else
  {
    NSLog(@"%@", JSONError);
  }
  
  if (battleInitResponse != nil && battleInitResponse.status == 0)
  {
//    self.battle = [self.battle updateWithBattleInitResponse:battleInitResponse];
  }
  
  if (battleConditionResponse != nil && battleConditionResponse.status == 0)
  {
//    self.battle = [self.battle updateWithBattleConditionResponse:battleInitResponse];
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
