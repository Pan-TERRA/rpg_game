//
//  RPGNetworkManager+Skills.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Skills.h"
#import "RPGSkillsRequest.h"
#import "RPGSkillsResponse+Serialization.h"
#import "RPGSkillInfoResponse+Serialization.h"
#import "NSUserDefaults+RPGSessionInfo.h"
// Constants
#import "RPGStatusCodes.h"

@implementation RPGNetworkManager (Skills)

- (void)fetchSkillsByCharacterID:(NSInteger)characterID completionHandler:(void (^)(NSInteger status, NSArray *skills))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPISkillsRoute];
  
  RPGSkillsRequest *aRequest = [[RPGSkillsRequest alloc] initWithToken:[NSUserDefaults standardUserDefaults].sessionToken
                                                           characterID:characterID];
  
  NSURLRequest *request = [self requestWithObject:aRequest URLstring:requestString method:@"POST"];
  
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
      if (error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet)
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          callbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection, nil);
        });
        
        return;
      }
      
      NSLog(@"Network error");
      NSLog(@"Domain: %@", error.domain);
      NSLog(@"Error Code: %ld", error.code);
      NSLog(@"Description: %@", [error localizedDescription]);
      NSLog(@"Reason: %@", [error localizedFailureReason]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerUnknown, nil);
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
        callbackBlock(kRPGStatusCodeNetworkManagerServerError, nil);
      });
      
      return;
    }
    
    //data empty
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData, nil);
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
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError, nil);
      });
      
      return;
    }

    RPGSkillsResponse *responseObject = [[[RPGSkillsResponse alloc]
                       initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
      });
      
      return;
    }
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(responseObject.status, responseObject.skills);
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

#pragma mark -

/**
  Skill info's keys are: @"name", @"description", @"multiplier"
*/
- (void)getSkillInfoByID:(NSInteger)ID completionHandler:(void (^)(NSInteger status, NSDictionary *skillInfo))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@%ld",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPISkillInfoRoute,
                             ID];
  
  NSURLRequest *request = [self requestWithObject:nil
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
      if (error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet)
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          callbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection, nil);
        });
        
        return;
      }
      
      NSLog(@"Network error");
      NSLog(@"Domain: %@", error.domain);
      NSLog(@"Error Code: %ld", error.code);
      NSLog(@"Description: %@", [error localizedDescription]);
      NSLog(@"Reason: %@", [error localizedFailureReason]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerUnknown, nil);
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
        callbackBlock(kRPGStatusCodeNetworkManagerServerError, nil);
      });
      
      return;
    }
    
    //data empty
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData, nil);
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
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError, nil);
      });
      
      return;
    }
    
    RPGSkillInfoResponse *responseObject = [[[RPGSkillInfoResponse alloc]
                                          initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
      });
      
      return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(responseObject.status, responseObject.skill);
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
