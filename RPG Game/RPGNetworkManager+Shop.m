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
#import "RPGShopUnitRequest.h"
  // Misc
#import "NSObject+RPGErrorLog.h"

@implementation RPGNetworkManager (Shop)


- (void)fetchShopUnitsWithCompletionHandler:(void (^)(RPGStatusCode networkStatusCode,
                                                      RPGShopUnitsResponse *shopUnitResponse))aCallbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIShopUnitsRoute];
  
  NSURLRequest *request = [self requestWithObject:@{}
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
    
    RPGShopUnitsResponse *responseObject = [[[RPGShopUnitsResponse alloc]
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
         aCallbackBlock(responseObject.status, responseObject);
       }
     });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
  
}

- (void)buyShopUnitWithUnitID:(NSInteger)unitID
            completionHandler:(void (^)(RPGStatusCode networkStatusCode))aCallbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIShopBuyUnitRoute];
  RPGShopUnitRequest *shopUnitRequest = [RPGShopUnitRequest shopUnitRequestWithShopUnitID:unitID];
  
  NSURLRequest *request = [self requestWithObject:shopUnitRequest
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
    
    dispatch_async(dispatch_get_main_queue(), ^
     {
        aCallbackBlock([responseDictionary[kRPGNetworkManagerStatus] integerValue]);
     });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];

}

@end
