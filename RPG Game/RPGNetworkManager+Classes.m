//
//  RPGNetworkManager+Classes.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Classes.h"
#import "RPGClassesResponse+Serialization.h"
#import "RPGClassInfoResponse+Serialization.h"
// Constants
#import "RPGStatusCodes.h"

@implementation RPGNetworkManager (Classes)

- (void)fetchClassesWithCompletionHandler:(void (^)(NSInteger status, NSArray *classes))callbackBlock;
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIClassesRoute];
  
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
    
    RPGClassesResponse *responseObject = [[[RPGClassesResponse alloc]
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
      callbackBlock(responseObject.status, responseObject.classes);
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

/**
 Class info's keys are: @"name", @"description", @"multiplier"
 */
- (void)getClassInfoByID:(NSInteger)ID completionHandler:(void (^)(NSInteger status, NSDictionary *skillInfo))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@%ld",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIClassInfoRoute,
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
    
    RPGClassInfoResponse *responseObject = [[[RPGClassInfoResponse alloc]
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
      callbackBlock(responseObject.status, responseObject.classInfo);
    });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}


@end
