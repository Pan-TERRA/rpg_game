  //
  //  RPGWebsocketManager.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 11/13/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGWebsocketManager.h"
  // API
#import "RPGNetworkManager.h"
#import "RPGNetworkManager+Skills.h"
  // Controllers
#import "RPGBattleController.h"
#import "RPGArenaController.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "NSObject+RPGErrorLog.h"
  // Constants
#import "RPGMessageTypes.h"
#import "RPGStatusCodes.h"

@interface RPGWebsocketManager () <SRWebSocketDelegate>

@property (copy, nonatomic, readwrite) NSString *token;
@property (retain, nonatomic, readwrite) SRWebSocket *webSocket;

@end

@implementation RPGWebsocketManager

#pragma mark - Init

- (instancetype)initWithURL:(NSURL *)anURL
{
  self = [super init];
  
  if (self != nil)
  {
    _URL = [anURL copy];
    _webSocket = [[SRWebSocket alloc] initWithURL:anURL];
    _webSocket.delegate = self;
    _token = [[NSUserDefaults standardUserDefaults].sessionToken copy];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_token release];
  [_webSocket release];
  
  [super dealloc];
}

#pragma mark - Actions

#pragma mark  Message Send

#pragma mark  API

- (void)open
{
  if (self.webSocket == nil)
  {
      // Create new webSocket
    self.webSocket = [[[SRWebSocket alloc] initWithURL:self.URL] autorelease];
    self.webSocket.delegate = self;
  }
  
  [self.webSocket open];
}

- (void)close
{
  [self.webSocket close];
}

- (void)sendWebsocketManagerMessageWithObject:(nonnull id<RPGSerializable>)anObject
{
  [self sendWebsocketManagerMessageWithObject:anObject
                            shouldInjectToken:YES];
}

- (void)sendWebsocketManagerMessageWithObject:(nonnull id<RPGSerializable>)anObject
                            shouldInjectToken:(BOOL)anInjectTokenFlag
{
    // logging
  NSLog(@"\r\nRequest:\r\n %@", [anObject dictionaryRepresentation]);
  
  NSError *JSONError = nil;
  NSData *data = nil;
  NSMutableDictionary *JSONObject = [[[anObject dictionaryRepresentation] mutableCopy] autorelease];
  
  if (anInjectTokenFlag)
  {
    NSString *token = self.token;
    if (token != nil)
    {
      JSONObject[kRPGRequestToken] = token;
    }
  }
  
  
  data = [NSJSONSerialization dataWithJSONObject:JSONObject
                                         options:NSJSONWritingPrettyPrinted
                                           error:&JSONError];
  
  if (data == nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from request"
                           userInfo:nil] raise];
  }
  else
  {
    [self.webSocket send:data];
  }
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)aWebSocket
{
  [self.battleController requestBattleInit];
}

- (void)webSocket:(SRWebSocket *)aWebSocket didReceiveMessage:(id)aMessage
{
  NSError *JSONError = nil;
  NSData *data = [(NSString *)aMessage dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&JSONError];
  if (responseDictionary != nil)
  {
      // logging
    NSLog(@"\r\nResponse:\r\n %@", responseDictionary);
    
    [self.battleController processManagerResponse:responseDictionary];
  }
  else
  {
    [self logError:JSONError withTitle:@"JSON error"];
  }
}


- (void)webSocket:(SRWebSocket *)aWebSocket didReceiveMessageWithString:(NSString *)aString
{
  
}

- (void)webSocket:(SRWebSocket *)aWebSocket didReceiveMessageWithData:(NSData *)aData
{
  
}

- (void)webSocket:(SRWebSocket *)aWebSocket didFailWithError:(NSError *)anError
{
  [self logError:anError withTitle:@"Battle manager error"];
}

- (void)webSocket:(SRWebSocket *)aWebSocket
 didCloseWithCode:(NSInteger)aCode
           reason:(nullable NSString *)aReason
         wasClean:(BOOL)aWasCleanFlag
{
  NSLog(@"Websocket did close \r\nWith code: %ld\r\nReason: %@", (long)aCode, aReason);
  self.webSocket = nil;
  [self.battleController dismissalDidFinish];
}

@end
