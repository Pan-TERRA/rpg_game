//
//  RPGNetworkManager+Quests.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Quests.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Entities
#import "RPGQuestListResponse+Serialization.h"
#import "RPGQuestRequest+Serialization.h"
#import "RPGQuestResponse+Serialization.h"
  // Constants
#import "RPGStatusCodes.h"

@implementation RPGNetworkManager (Quests)

- (void)fetchQuestsByState:(RPGQuestListState)aState completionHandler:(void (^)(NSInteger status, NSArray *quests))callbackBlock
{
  NSString *requestString = nil;
  NSDictionary *requestDictionary = @{ @"token" : [[NSUserDefaults standardUserDefaults] sessionToken] };
  
  switch (aState)
  {
    case kRPGQuestListTakeQuest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIQuestsRoute];
      break;
    }
    case kRPGQuestListInProgressQuest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIQuestsInProgressRoute];
      break;
    }
    case kRPGQuestListDoneQuest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIConfirmedQuestsRoute];
      break;
    }
    case kRPGQuestListReviewQuest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIReviewQuestsRoute];
      break;
    }
    default:
      break;
  }
  
  NSURLRequest *request = [self requestWithObject:requestDictionary URLstring:requestString method:@"POST"];
  
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
    
    RPGQuestListResponse *responseObject = nil;
    responseObject = [[[RPGQuestListResponse alloc]
                       initWithDictionaryRepresentation:responseDictionary] autorelease];
      // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError, nil);
      });
      
      return;
    }
    else if (responseObject.status == kRPGStatusCodeOk)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(responseObject.status, responseObject.quests);
      });
    }

  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)takeQuestWithRequest:(RPGQuestRequest *)aRequest completionHandler:(void (^)(NSInteger status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIAcceptQuestRoute];
  
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
          callbackBlock(kRPGStatusCodeNetworkManagerNoInternetConnection);
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
    
    RPGQuestResponse *responseObject = nil;
    responseObject = [[[RPGQuestResponse alloc]
                       initWithDictionaryRepresentation:responseDictionary] autorelease];
      // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError);
      });
      return;
    }
    else if (responseObject.status == kRPGStatusCodeOk)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(responseObject.status);
      });
    }
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
