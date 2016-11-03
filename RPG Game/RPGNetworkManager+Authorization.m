  //
  //  RPGNetworkManager+Authorization.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/18/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

  // Entities
#import "RPGNetworkManager+Authorization.h"
#import "RPGAuthorizationLoginRequest+Serialization.h"
#import "RPGAuthorizationLoginResponse+Serialization.h"
#import "RPGAuthorizationLogoutRequest+Serialization.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGStatusCodes.h"


@implementation RPGNetworkManager (Authorization)

#pragma mark - Authorization API

- (void)loginWithRequest:(RPGAuthorizationLoginRequest *)aRequest
       completionHandler:(void (^)(NSInteger))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPILoginRoute];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                               URLstring:requestString
                                                  method:@"POST"];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
      // something went wrong
    if (error != nil)
    {
        // no internet connection
      if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorNotConnectedToInternet)
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          callbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection);
        });
        return;
      }
      
      NSLog(@"Network error");
      NSLog(@"Domain: %@", error.domain);
      NSLog(@"Error Code: %d", error.code);
      NSLog(@"Description: %@", [error localizedDescription]);
      NSLog(@"Reason: %@", [error localizedFailureReason]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerUnknown);
      });
      return;
    }
    
      // server status code
    NSInteger responseStatusCode = [(NSHTTPURLResponse *)response statusCode];
    if (responseStatusCode != 200)
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)responseStatusCode);
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerServerError);
      });
      return;
    }
    
      //data empty
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData);
      });
      return;
    }
    
    NSError *JSONParsingError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&JSONParsingError];
      // serialization error
    if (responseDictionary == nil)
    {
      NSLog(@"JSON Error");
      NSLog(@"Domain: %@", JSONParsingError.domain);
      NSLog(@"Error Code: %ld", (long)JSONParsingError.code);
      NSLog(@"Description: %@", [JSONParsingError localizedDescription]);
      NSLog(@"Reason: %@", [JSONParsingError localizedFailureReason]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError);
      });
      return;
    }
    
    RPGAuthorizationLoginResponse *responseObject = nil;
    responseObject = [[[RPGAuthorizationLoginResponse alloc]
                           initWithDictionaryRepresentation:responseDictionary] autorelease];
      // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
      });
      return;
    }
    else if (responseObject.status == kRPGStatusCodeOk)
    {
      [responseObject store];
    }
  
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(responseObject.status);
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)logoutWithCompletionHandler:(void (^)(NSInteger))callbackBlock
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  RPGAuthorizationLogoutRequest *request = [RPGAuthorizationLogoutRequest requestWithToken:token];
  
  [self logoutWithRequest:request completionHandler:callbackBlock];
}

- (void)logoutWithRequest:(RPGAuthorizationLogoutRequest *)aRequest
        completionHandler:(void (^)(NSInteger))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPISignoutRoute];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
      // something went wrong
    if (error != nil)
    {
        // no internet connection
      if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorNotConnectedToInternet)
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          callbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection);
        });
        return;
      }
      
      NSLog(@"Network error");
      NSLog(@"Domain: %@", error.domain);
      NSLog(@"Error Code: %d", error.code);
      NSLog(@"Description: %@", [error localizedDescription]);
      NSLog(@"Reason: %@", [error localizedFailureReason]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerUnknown);
      });
      return;
    }
    
      // server status code
    NSInteger responseStatusCode = [(NSHTTPURLResponse *)response statusCode];
    if (responseStatusCode != 200)
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)responseStatusCode);
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerServerError);
      });
      return;
    }
    
      //data empty
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData);
      });
      return;
    }
    
    NSError *JSONParsingError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&JSONParsingError];
      // serialization error
    if (responseDictionary == nil)
    {
      NSLog(@"JSON Error");
      NSLog(@"Domain: %@", JSONParsingError.domain);
      NSLog(@"Error Code: %ld", (long)JSONParsingError.code);
      NSLog(@"Description: %@", [JSONParsingError localizedDescription]);
      NSLog(@"Reason: %@", [JSONParsingError localizedFailureReason]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError);
      });
      return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      //TODO: remove hardcode
      callbackBlock([responseDictionary[@"status"] integerValue]);
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
