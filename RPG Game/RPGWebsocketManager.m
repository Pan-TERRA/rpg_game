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

typedef void (^fetchSkillsCompletionHandler)(NSInteger, NSArray *);

@interface RPGWebsocketManager () <SRWebSocketDelegate>

@property (assign, nonatomic, readwrite) RPGBattleController *battleController;
@property (copy, nonatomic, readwrite) NSString *token;

@end

@implementation RPGWebsocketManager

@synthesize delegate = _delegate;

#pragma mark - Init

- (instancetype)initWithBattleController:(id)aBattleController URL:(NSURL *)anURL
{
  self = [super initWithURL:anURL];
  
  if (self != nil)
  {
    _battleController = aBattleController;
    _delegate = self;
    _token = [[NSUserDefaults standardUserDefaults].sessionToken copy];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_token release];
  
  [super dealloc];
}

#pragma mark - Actions

#pragma mark  Message Send

#pragma mark  API

- (void)sendWebsocketManagerMessageWithObject:(id<RPGSerializable>)anObject
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
                             reason:@"JSON cannot be retrieved from request"
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
  [self.battleController requestBattleInit];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
  NSError *JSONError = nil;
  NSData *data = [(NSString *)message dataUsingEncoding:NSUTF8StringEncoding];
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


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
  [self logError:error withTitle:@"Battle manager error"];
}

- (void)webSocket:(SRWebSocket *)webSocket
 didCloseWithCode:(NSInteger)code
           reason:(nullable NSString *)reason
         wasClean:(BOOL)wasClean
{
  NSLog(@"Websocket did close \r\nWith code: %ld\r\nReason: %@", (long)code, reason);
}


@end
