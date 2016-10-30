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
#import "RPGQuestReviewRequest+Serialization.h"
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
  }
  
  NSURLRequest *request = [self requestWithObject:requestDictionary URLstring:requestString method:@"POST"];
  
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
      NSLog(@"Error Code: %d", error.code);
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
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
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

- (void)doQuestAction:(RPGQuestAction)anAction request:(RPGQuestRequest *)aRequest completionHandler:(void (^)(NSInteger status))callbackBlock
{
  NSString *requestString = nil;
  
  switch (anAction)
  {
    case kRPGQuestActionTakeQuest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIAcceptQuestRoute];
      break;
    }
    case kRPGQuestActionDeleteQuest:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPISkipQuestRoute];
      break;
    }
  }
  
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
      NSLog(@"Error Code: %d", error.code);
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
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
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

- (void)addProofWithRequest:(RPGQuestRequest *)aRequest imageData:(NSData *)imageData completionHandler:(void (^)(NSInteger status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIProofQuestRoute];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString]];
  
  NSError *JSONSerializationError = nil;
  request.HTTPMethod = @"POST";
  
  NSDictionary *requestDictionary = [aRequest dictionaryRepresentation];
  NSData *requestJSONData = [NSJSONSerialization dataWithJSONObject:requestDictionary
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&JSONSerializationError];
  if (requestJSONData == nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from request"
                           userInfo:nil] raise];
  }

    // build HTTP body
  NSString *boundary = @"---------------------------Boundary Line---------------------------";
  NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
  [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
  
  NSMutableData *body = [NSMutableData data];
  
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Disposition: form-data; name=\"json\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:requestJSONData];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Disposition: form-data; name=\"prove_image\"; filename=\"file.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:imageData];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

  request.HTTPBody = body;
  // END build HTTP body
  
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
      NSLog(@"Error Code: %d", error.code);
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
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
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

- (void)getImageProofDataFromURL:(NSURL *)url completionHandler:(void (^)(NSData *imageData))callbackBlock
{
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  request.HTTPMethod = @"GET";

  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  // ???: Tramper quetion. downloadTask
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
      // TODO: validation
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(data);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)postQuestProofWithRequest:(RPGQuestReviewRequest *)aRequest completionHandler:(void (^)(NSInteger status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIReviewResultQuestRoute];
  
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
      NSLog(@"Error Code: %d", error.code);
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
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
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
