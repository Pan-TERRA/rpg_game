//
//  RPGNetworkManager (Friends).m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Friends.h"
  // Entity
#import "RPGBasicNetworkResponse.h"
#import "RPGFriendListResponse.h"
#import "RPGFriendRequest.h"
#import "RPGAddFriendRequest.h"
  // Misc
#import "NSObject+RPGErrorLog.h"

@implementation RPGNetworkManager (Friends)

- (void)fetchFriendsWithCompletionHandler:(void (^)(RPGStatusCode, NSArray<NSDictionary *> *))aCallback
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIFriendsRoute];
  
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
    if (responseDictionary == nil)
    {
      [self logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(kRPGStatusCodeNetworkManagerSerializingError, nil);
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
         aCallback(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
       }
       else
       {
         aCallback(responseObject.status, responseObject.friends);
       }
     });
    
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)addPlayerToFriendsWithRequest:(RPGAddFriendRequest *)aRequest
                    completionHandler:(void (^)(RPGStatusCode))aCallback
{
    NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIAddFriendRoute];
  
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
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
       });
    }
    else
    {
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(responseObject.status);
       });
    }
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)doFriendAction:(RPGFriendsNetworkAction)anAction
           withRequest:(RPGFriendRequest *)aRequest
     completionHandler:(void (^)(RPGStatusCode))aCallback
{
  NSString *requestString = nil;
  
  switch (anAction)
  {
    case kRPGFriendsNetworkActionCancelFriendRequest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPICancelFriendRequestRoute];
      break;
    }
      
    case kRPGFriendsNetworkActionDeleteFriendRequest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIDeleteFriendRoute];
      break;
    }
      
    case kRPGFriendsNetworkActionAcceptFriendRequest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                                 kRPGNetworkManagerAPIHost,
                                 kRPGNetworkManagerAPIAcceptFriendRequestRoute];
      break;
    }
      
    case kRPGFriendsNetworkActionSkipFriendRequest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPISkipFriendRequestRoute];
      break;
    }
      
      case kRPGFriendsNetworkActionSendChallengeRequest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPISendQuestChallengeRoute];
      break;
    }
      
    default:
    {
      requestString = [NSString string];
      
      break;
    }
  }
  
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
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
       });
    }
    else
    {
      dispatch_async(dispatch_get_main_queue(), ^
       {
         aCallback(responseObject.status);
       });
    }
  }];

  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
