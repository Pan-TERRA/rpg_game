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
  
  NSError *JSONSerializationError = nil;
  request.HTTPMethod = @"POST";
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[aRequest dictionaryRepresentation]
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&JSONSerializationError];
  
  if (JSONSerializationError != nil)
  {
   [[NSException exceptionWithName:NSInvalidArgumentException
                            reason:@"JSON cannot be retrieved from login request"
                          userInfo:nil] raise];
  }
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
    NSInteger status = 0;
    NSError *JSONParsingError = nil;
    RPGAuthorizationLoginResponse *responseObject = nil;
    
    if (error != nil)
    {
      status = 1;
    }
    
    
    if (data != nil)
    {
      NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&JSONParsingError];
      
      if (JSONParsingError != nil)
      {
          // ???: tramper question
        status = 3;
      }
      else
      {
        responseObject = [[[RPGAuthorizationLoginResponse alloc]
                           initWithDictionaryRepresentation:responseDictionary] autorelease];
      }

    }
    else
    {
      status = 2;
    }
    
    if (responseObject == nil)
    {
      status = 4;
    }
    
    status = (status != 0) ? status : responseObject.status;
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(status);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)logoutWithCompletionHandler:(void (^)(NSInteger))callbackBlock
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
  NSError *JSONSerializationError = nil;
  request.HTTPMethod = @"POST";
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[aRequest dictionaryRepresentation]
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
  
  if (JSONSerializationError != nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from logout request"
                           userInfo:nil] raise];
  }
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
    NSDictionary *responseDictionary = nil;
    NSInteger status = 0;
    NSError *JSONParsingError = nil;
    

    if (error != nil)
    {
      status = 1;
    }
    
    
    if (data != nil)
    {
      responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:&JSONParsingError];
      
      if (JSONParsingError != nil)
      {
          // ???: tramper question
        status = 3;
      }
      else
      {
          // ???: tramper question
      }
    }
    else
    {
      status = 2;
    }
    
    status = (status != 0) ? status : [responseDictionary[@"status"] integerValue];
  
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(status);
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
