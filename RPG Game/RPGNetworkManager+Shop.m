//
//  RPGNetworkManager+Shop.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Shop.h"
  // Entities
#import "RPGShopUnitsResponse.h"
#import "RPGShopUnitRequest.h"
#import "RPGBasicNetworkResponse.h"
  // Misc
#import "NSObject+RPGErrorLog.h"

@implementation RPGNetworkManager (Shop)

- (void)fetchShopUnitsWithCompletionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                                      RPGShopUnitsResponse *aShopUnitResponse))aCallback
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIShopUnitsRoute];
  
  NSURLRequest *request = [self requestWithObject:@{}
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
      if ([self isNoInternerConnection:error])
      {
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(kRPGStatusCodeNetworkManagerNoInternetConnection, nil);
       });
        
        return;
      }
      
      [self logError:error withTitle:@"Network error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(kRPGStatusCodeNetworkManagerUnknown, nil);
       });
      
      return;
    }
    
    // server status code
    if ([self isResponseCodeNot200:response])
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
      
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(kRPGStatusCodeNetworkManagerServerError, nil);
       });
      
      return;
    }
    
    if (data == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(kRPGStatusCodeNetworkManagerEmptyResponseData, nil);
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
         aCallback(kRPGStatusCodeNetworkManagerSerializingError, nil);
       });
      
      return;
    }
    
    RPGShopUnitsResponse *responseObject = [[[RPGShopUnitsResponse alloc]
                                             initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    dispatch_async(dispatch_get_main_queue(), ^
     {
       if (responseObject == nil)
       {
         aCallback(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
       }
       else
       {
         aCallback(responseObject.status, responseObject);
       }
     });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
  
}

- (void)buyShopUnitWithRequest:(RPGShopUnitRequest *)aRequest
            completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIShopBuyUnitRoute];
  
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
