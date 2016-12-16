//
//  RPGNetworkManager+Registration.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Registration.h"
  // Entities
#import "RPGRegistrationRequest.h"
#import "RPGBasicNetworkResponse.h"
  // Misc
#import "NSObject+RPGErrorLog.h"

@implementation RPGNetworkManager (Registration)

- (void)registerWithRequest:(RPGRegistrationRequest *)aRequest
          completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIRegisterRoute];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"
                                shouldInjectToken:NO];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error)
  {
    if (error != nil)
    {
      if ([self isNoInternerConnection:error])
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          aCallback(kRPGStatusCodeNetworkManagerNoInternetConnection);
        });
        return;
      }
      
      [self logError:error withTitle:@"Network error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallback(kRPGStatusCodeNetworkManagerUnknown);
      });
      return;
    }
    
    if ([self isResponseCodeNot200:response])
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallback(kRPGStatusCodeNetworkManagerServerError);
      });
      return;
    }
    
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallback(kRPGStatusCodeNetworkManagerEmptyResponseData);
      });
      return;
    }
    
    NSError *JSONParsingError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&JSONParsingError];
    
      // parse error
    if (responseDictionary == nil)
    {
      [self logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallback(kRPGStatusCodeNetworkManagerSerializingError);
      });
      return;
    }
    
    RPGBasicNetworkResponse *responseObject = [[[RPGBasicNetworkResponse alloc]
                                                initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (responseObject == nil)
      {
        aCallback(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
      }
      else
      {
        aCallback(responseObject.status);
      }
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
