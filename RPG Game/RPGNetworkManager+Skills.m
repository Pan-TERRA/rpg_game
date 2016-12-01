//
//  RPGNetworkManager+Skills.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Skills.h"
  // Entities
#import "RPGBasicNetworkResponse.h"
#import "RPGSkillInfoResponse.h"
#import "RPGSkillsSelectRequest.h"
#import "RPGSkillsResponse.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "NSObject+RPGErrorLog.h"

@implementation RPGNetworkManager (Skills)

- (void)fetchSkillsByCharacterID:(NSInteger)aCharacterID
               completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                           NSArray *aSkillsArray))aCallbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPISkillsRoute];
  

  RPGCharacterRequest *aRequest = [RPGCharacterRequest characterRequestWithCharacterID:aCharacterID];

  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"
                                      injectToken:NO];

  
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
      if ([self isNoInternerConnection:error])
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          aCallbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection, nil);
        });
        
        return;
      }
      
      [self logError:error withTitle:@"Network error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerUnknown, nil);
      });
      
      return;
    }
    
    // server status code
    if ([self isResponseCodeNot200:response])
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerServerError, nil);
      });
      
      return;
    }
    
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData, nil);
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
      [self logError:JSONParsingError withTitle:@"JSON Error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerSerializingError, nil);
      });
      
      return;
    }

    RPGSkillsResponse *responseObject = [[[RPGSkillsResponse alloc]
                                          initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (responseObject == nil)
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
      }
      else
      {
        aCallbackBlock(responseObject.status, responseObject.skills);
      }
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)getSkillInfoByID:(NSInteger)anID
       completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                   NSDictionary *aSkillInfoDictionary))aCallbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@%ld",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPISkillInfoRoute,
                             (long)anID];
  
  NSURLRequest *request = [self requestWithObject:nil
                                        URLstring:requestString
                                           method:@"GET"
                                      injectToken:NO];
  
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
      if ([self isNoInternerConnection:error])
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          aCallbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection, nil);
        });
        
        return;
      }
      
      [self logError:error withTitle:@"Network error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerUnknown, nil);
      });
      
      return;
    }
    
    if ([self isResponseCodeNot200:response])
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerServerError, nil);
      });
      
      return;
    }
    
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData, nil);
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
      [self logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerSerializingError, nil);
      });
      
      return;
    }
    
    RPGSkillInfoResponse *responseObject = [[[RPGSkillInfoResponse alloc]
                                             initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (responseObject == nil)
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
      }
      else
      {
        aCallbackBlock(responseObject.status, responseObject.skill);
      }
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)selectSkillsWithRequest:(RPGSkillsSelectRequest *)aRequest
              completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPISelectSkillsRoute];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"
                                      injectToken:YES];
  
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
      if ([self isNoInternerConnection:error])
      {
        dispatch_async(dispatch_get_main_queue(), ^
        {
          aCallbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection);
        });
        
        return;
      }
      
      [self logError:error withTitle:@"Network error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerUnknown);
      });
      
      return;
    }
    
    if ([self isResponseCodeNot200:response])
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerServerError);
      });
      
      return;
    }
    
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData);
      });
      
      return;
    }
    
    NSError *JSONParsingError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&JSONParsingError];
    if (responseDictionary == nil)
    {
      [self logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerSerializingError);
      });
      
      return;
    }
    
    RPGBasicNetworkResponse *responseObject = nil;
    responseObject = [[[RPGBasicNetworkResponse alloc]
                       initWithDictionaryRepresentation:responseDictionary] autorelease];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (responseObject == nil)
      {
        aCallbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
      }
      else
      {
        aCallbackBlock(responseObject.status);
      }
   });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
