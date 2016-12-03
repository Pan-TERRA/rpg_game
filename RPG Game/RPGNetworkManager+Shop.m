//
//  RPGNetworkManager+Shop.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Shop.h"
  // Entity
#import "RPGShopUnitsResponse.h"
#import "RPGShopBuyUnitRequest.h"
  // Misc
#import "NSObject+RPGErrorLog.h"

@implementation RPGNetworkManager (Shop)


- (void)fetchShopUnitsWithCompletionHandler:(void (^)(RPGStatusCode networkStatusCode,
                                                      RPGShopUnitsResponse *))callbackBlock
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
                         callbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection, nil);
                       });
        
        return;
      }
      
      [self logError:error withTitle:@"Network error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerUnknown, nil);
                     });
      
      return;
    }
    
    // server status code
    if ([self isResponseCodeNot200:response])
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
      
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerServerError, nil);
                     });
      
      return;
    }
    
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
      [self logError:JSONParsingError withTitle:@"JSON Error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerSerializingError, nil);
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
                       callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
                     }
                     else
                     {
                       callbackBlock(responseObject.status, responseObject);
                     }
                   });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
  
}

- (void)buyShopUnitWithUnitID:(NSInteger)unitID
            completionHandler:(void (^)(NSInteger))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIShopBuyUnitRoute];
  RPGShopBuyUnitRequest *shopUnitRequest = [RPGShopBuyUnitRequest shopBuyUnitRequestWithShopUnitID:unitID];
  
  NSURLRequest *request = [self requestWithObject:shopUnitRequest
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
                         callbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection);
                       });
        
        return;
      }
      
      [self logError:error withTitle:@"Network error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerUnknown);
                     });
      
      return;
    }
    
    if ([self isResponseCodeNot200:response])
    {
      NSLog(@"Network error. HTTP status code: %ld", (long)[(NSHTTPURLResponse *)response statusCode]);
      
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerServerError);
                     });
      
      return;
    }
    
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
    if (responseDictionary == nil)
    {
      [self logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerSerializingError);
                     });
      
      return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                      callbackBlock([responseDictionary[kRPGNetworkManagerStatus] integerValue]);
                   });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];

}

@end
