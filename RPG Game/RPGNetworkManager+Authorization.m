//
//  RPGNetworkManager+Authorization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Authorization.h"

@implementation RPGNetworkManager (Authorization)

#pragma mark - Authorization API

- (void)loginWithRequest:(RPGAuthorizationLoginRequest *)aRequest completionHandler:(void (^)(NSInteger))callbackBlock
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
    [responseObject store];
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock([responseDictionary[@"status"] integerValue]);
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

- (void)logoutWithRequest:(RPGAuthorizationLogoutRequest *)aRequest completionHandler:(void (^)(NSInteger))callbackBlock
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
    
      // add response object ?
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
    callbackBlock([responseDictionary[@"status"] intValue]);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
