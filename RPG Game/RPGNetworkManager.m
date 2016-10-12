//
//  RPGNetworkManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGAuthorizationRequest+Serialization.h"

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

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - Authorization API

- (void)login
{
  
}

- (void)loginWithRequest:(RPGAuthorizationRequest *)aRequest
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"10.55.33.28:8000"];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:0];
  
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[aRequest dictionaryRepresentation] options:NSJSONWritingPrettyPrinted error:nil];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // ???: YES or NO
  configuration.allowsCellularAccess = NO;
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                           completionHandler:^(NSData * _Nullable data,
                                                               NSURLResponse * _Nullable response,
                                                               NSError * _Nullable error)
  {
  
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", responseDictionary);
  
   
  }];
                                
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)logout
{
  
}

- (void)registration
{
  
}

#pragma mark - Authorization API

- (void)fetchQuestByType:(int)aType {
	
}





@end