//
//  RPGNetworkManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGAuthorizationLoginRequest+Serialization.h"
#import "RPGAuthorizationLoginResponse+Serialization.h"
#import "RPGAuthorizationLogoutRequest+Serialization.h"
#import "RPGAuthorizationLogoutResponse+Serialization.h"

static RPGNetworkManager *sharedNetworkManager = nil;

@interface RPGNetworkManager ()

@property (copy, nonatomic) NSString *token;

@end

@implementation RPGNetworkManager

#pragma mark - Init

- (id)init
{
  self = [super init];
  
  if (self != nil)
  {
    _token = [[NSString alloc] init];
  }
  
  return self;
}

+ (id)sharedNetworkManager
{
  @synchronized(self)
  {
    if(sharedNetworkManager == nil)
    {
      sharedNetworkManager = [[super allocWithZone:NULL] init];
    }
  }
  
  return sharedNetworkManager;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - Singleton

+ (id)allocWithZone:(NSZone *)zone
{
  return [[self sharedNetworkManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

- (id)retain
{
  return self;
}

- (NSUInteger)retainCount
{
  return UINT_MAX;
}

- (oneway void)release
{
  
}

- (id)autorelease
{
  return self;
}

#pragma mark - Authorization API


  // replace to login screen

//- (void)login
//{
//  RPGAuthorizationRequest *request = [[RPGAuthorizationRequest alloc] initWithEmail:@"eleonoria@gmail.com" password:@"eleonoria"];
//  
//  [self  loginWithRequest:request block:^(RPGAuthorizationResponse *response)
//  {
//    
//  }];
//  
//  [request release];
//  
//  
//}

- (void)loginWithRequest:(RPGAuthorizationLoginRequest *)aRequest block:(void (^)(RPGAuthorizationLoginResponse *))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/login"];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:0];
  
  request.HTTPMethod = @"POST";
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[aRequest dictionaryRepresentation]
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                           completionHandler:^(NSData * _Nullable data,
                                                               NSURLResponse * _Nullable response,
                                                               NSError * _Nullable error)
  {
  
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", responseDictionary);
    RPGAuthorizationLoginResponse *loginResponse = [[RPGAuthorizationLoginResponse alloc]
                                               initWithDictionaryRepresentation:responseDictionary];
    
  
    callbackBlock(loginResponse);
    
    [loginResponse release];
  }];
                                
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)logout
{
  RPGAuthorizationLogoutRequest *request = [[RPGAuthorizationLogoutRequest alloc] initWithToken:self.token];
  
  [self  logoutWithRequest:request block:^(BOOL status)
  {
    if (status == 0)
    {
        // send logoutstatus
    }
    else
    {
      // send logout error status
    }
  }];
  
  [request release];
}

- (void)logoutWithRequest:(RPGAuthorizationLogoutRequest *)aRequest block:(void (^)(BOOL))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/signout"];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:0];
  
  request.HTTPMethod = @"POST";
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[aRequest dictionaryRepresentation]
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
    
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:nil];
    NSLog(@"%@", responseDictionary);
    RPGAuthorizationLogoutResponse *logoutResponse = [[RPGAuthorizationLogoutResponse alloc] initWithDictionaryRepresentation:responseDictionary];
    
    callbackBlock(logoutResponse);
    
    [logoutResponse release];
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)registration
{
  
}

#pragma mark - Authorization API

- (void)fetchQuestByType:(int)aType
{
	
}





@end