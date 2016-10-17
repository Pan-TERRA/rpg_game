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
#import "RPGRegistrationRequest+Serialization.h"

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

- (void)loginWithRequest:(RPGAuthorizationLoginRequest *)aRequest completionHandler:(void (^)(RPGAuthorizationLoginResponse *))callbackBlock
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
  
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:nil];
    
    RPGAuthorizationLoginResponse *responseObject = [[[RPGAuthorizationLoginResponse alloc]
                                                      initWithDictionaryRepresentation:responseDictionary]
                                                     autorelease];
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(responseObject);
    });
  }];
                                
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)logoutWithCompletionHandler:(void (^)(int))callbackBlock
{
  RPGAuthorizationLogoutRequest *request = [[RPGAuthorizationLogoutRequest alloc] initWithToken:self.token];
  
  [self logoutWithRequest:request completionHandler:callbackBlock];
  
  [request release];
}

- (void)logoutWithRequest:(RPGAuthorizationLogoutRequest *)aRequest completionHandler:(void (^)(int))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/singout"];
  
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
                                  
    // add response object ?
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock([responseDictionary[@"status"] intValue]);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)registerWithRequest:(RPGRegistrationRequest *)aRequest completionHandler:(void (^)(int))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/register"];
  
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
                                          completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error)
  {
    
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock([responseDictionary[@"status"] intValue]);
    });
  }];
                                
  [task resume];

  [session finishTasksAndInvalidate];
}

#pragma mark - Authorization API

- (void)fetchQuestByType:(int)aType
{
	
}

@end