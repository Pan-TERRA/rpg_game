//
//  RPGNetworkManager+Quests.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Quests.h"
  // Entities
#import "RPGQuestListResponse.h"
#import "RPGQuestRequest.h"
#import "RPGQuestResponse.h"
#import "RPGQuestReviewRequest.h"
  //Misc
#import "NSObject+RPGErrorLog.h"
#import "NSUserDefaults+RPGSessionInfo.h"

@implementation RPGNetworkManager (Quests)

- (void)fetchQuestsByState:(RPGQuestListState)aState completionHandler:(void (^)(NSInteger status, NSArray *quests))callbackBlock
{
  NSString *requestString = nil;
  
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
    
    RPGQuestListResponse *responseObject = nil;
    responseObject = [[[RPGQuestListResponse alloc]
                       initWithDictionaryRepresentation:responseDictionary] autorelease];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (responseObject == nil)
      {
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
      }
      else
      {
        callbackBlock(responseObject.status, responseObject.quests);
      }
    });
  
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
    
    RPGQuestResponse *responseObject = [[[RPGQuestResponse alloc]
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

- (void)addProofWithRequest:(RPGQuestRequest *)aRequest imageData:(NSData *)imageData completionHandler:(void (^)(NSInteger status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIProofQuestRoute];

  NSMutableURLRequest *request = [[self requestWithObject:aRequest URLstring:requestString method:@"POST" injectToken:YES] mutableCopy];

    // build HTTP body
  NSString *boundary = @"---------------------------Boundary Line---------------------------";
  NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
  [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
  
  NSMutableData *body = [NSMutableData data];
  
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Disposition: form-data; name=\"json\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:request.HTTPBody];
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
    // serialization error
    if (responseDictionary == nil)
    {
      [self  logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError);
      });
      return;
    }
    
    RPGQuestResponse *responseObject = [[[RPGQuestResponse alloc]
                                         initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (responseObject == nil)
      {
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
      }
      else
      {
        callbackBlock(responseObject.status);
      }
    });

  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)getImageProofDataFromURL:(NSURL *)url completionHandler:(void (^)(RPGStatusCode statusCode, NSData *imageData))callbackBlock
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
    if (error != nil)
    {
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
    
   
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (data == nil)
      {
        callbackBlock(kRPGStatusCodeNetworkManagerEmptyResponseData, nil);
      }
      else
      {
        callbackBlock(kRPGStatusCodeOK, data);
      }
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
      // serialization error
    if (responseDictionary == nil)
    {
      [self logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerSerializingError);
      });
      return;
    }
    
    RPGQuestResponse *responseObject = [[[RPGQuestResponse alloc]
                                         initWithDictionaryRepresentation:responseDictionary] autorelease];
      // validation error
    dispatch_async(dispatch_get_main_queue(), ^
    {
      if (responseObject == nil)
      {
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail);
      }
      else
      {
        callbackBlock(responseObject.status);
      }
    });

  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
