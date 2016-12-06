//
//  RPGNetworkManager (Friends).m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Friends.h"
  // Entity
#import "RPGFriendListResponse.h"
#import "RPGFriendAddRequest.h"
#import "RPGFriendAddResponse.h"
#import "RPGFriendConfirmRequest.h"
#import "RPGFriendConfirmResponse.h"
#import "RPGQuestChallengeRequest.h"
#import "RPGQuestChallengeResponse.h"
#import "RPGConfirmChallengeRequest.h"
#import "RPGConfirmChallengeResponse.h"
  // Misc
#import "NSObject+RPGErrorLog.h"


@implementation RPGNetworkManager (Friends)

- (void)fetchFriendsWithCompletionHandler:(void (^)(RPGStatusCode, NSArray *friends))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             @"UnknownRoute"];
  
  NSURLRequest *request = [self requestWithObject:@{}
                                        URLstring:requestString
                                           method:@"POST"
                                      shouldInjectToken:YES];
  
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
    if (responseDictionary == nil)
    {
      [self logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerSerializingError, nil);
                     });
      
      return;
    }
    
    RPGFriendListResponse *responseObject = nil;
    responseObject = [[[RPGFriendListResponse alloc]
                       initWithDictionaryRepresentation:responseDictionary] autorelease];
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                     if (responseObject == nil)
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
                     }
                     else
                     {
                       callbackBlock(responseObject.status, responseObject.friends);
                     }
                   });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)addPlayerToFriendsWithRequest:(RPGFriendAddRequest *)aRequest
                    completionHandler:(void (^)(RPGStatusCode status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             @"UnknownRoute"];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"
                                      shouldInjectToken:YES];
  
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
    
    RPGFriendAddResponse *responseObject = [[[RPGFriendAddResponse alloc]
                                         initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
                     });
    }
    else
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

- (void)confirmFriendWithRequest:(RPGFriendConfirmRequest *)aRequest
               completionHandler:(void (^)(RPGStatusCode status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             @"UnknownRoute"];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"
                                      shouldInjectToken:YES];
  
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
    
    RPGFriendConfirmResponse *responseObject = [[[RPGFriendConfirmResponse alloc]
                                             initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
                     });
    }
    else
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

- (void)postQuestChallengeWith:(RPGQuestChallengeRequest *)aRequest
             completionHandler:(void (^)(RPGStatusCode status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             @"UnknownRoute"];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"
                                      shouldInjectToken:YES];
  
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
    
    RPGQuestChallengeResponse *responseObject = [[[RPGQuestChallengeResponse alloc]
                                             initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
                     });
    }
    else
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

- (void)confirmQuestChallengeWith:(RPGConfirmChallengeRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             @"UnknownRoute"];
  
  NSURLRequest *request = [self requestWithObject:aRequest
                                        URLstring:requestString
                                           method:@"POST"
                                      shouldInjectToken:YES];
  
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
    
    RPGConfirmChallengeResponse *responseObject = [[[RPGConfirmChallengeResponse alloc]
                                                 initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
                     {
                       callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
                     });
    }
    else
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
