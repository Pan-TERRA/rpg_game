//
//  RPGNetworkManager+Quests.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Quests.h"
  // Entities
#import "RPGQuestReviewRequest.h"
#import "RPGBasicNetworkResponse.h"
#import "RPGIncomingDuelQuestListResponse.h"
  // Misc
#import "NSObject+RPGErrorLog.h"
#import "NSUserDefaults+RPGSessionInfo.h"

@implementation RPGNetworkManager (Quests)

- (void)fetchQuestsByType:(RPGQuestType)aType
                    state:(RPGQuestListState)aState
        completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                    RPGQuestListResponse *aResponse))aCallback
{
  NSString *requestString = nil;
  
  switch (aType) {
    case kRPGQuestTypeSingle:
    {
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
      break;
    }
    case kRPGQuestTypeDuel:
    {
      switch (aState)
      {
        case kRPGQuestListTakeQuest:
        {
          requestString = [NSString stringWithFormat:@"%@%@",
                           kRPGNetworkManagerAPIHost,
                           kRPGNetworkManagerAPIDuelIncomingQuestsRoute];
          break;
        }
          
        case kRPGQuestListInProgressQuest:
        {
          requestString = [NSString stringWithFormat:@"%@%@",
                           kRPGNetworkManagerAPIHost,
                           kRPGNetworkManagerAPIDuelQuestsInProgressRoute];
          break;
        }
          
        case kRPGQuestListDoneQuest:
        {
          requestString = [NSString stringWithFormat:@"%@%@",
                           kRPGNetworkManagerAPIHost,
                           kRPGNetworkManagerAPIDuelConfirmedQuestsRoute];
          break;
        }
          
        case kRPGQuestListReviewQuest:
        {
          requestString = [NSString stringWithFormat:@"%@%@",
                           kRPGNetworkManagerAPIHost,
                           kRPGNetworkManagerAPIDuelReviewQuestsRoute];
          break;
        }
      }
      break;
    }
  }
  
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
    
    RPGQuestListResponse *responseObject = nil;
    if (aState == kRPGQuestListTakeQuest && aType == kRPGQuestTypeDuel)
    {
      responseObject = [[[RPGIncomingDuelQuestListResponse alloc]
                         initWithDictionaryRepresentation:responseDictionary] autorelease];
    }
    else
    {
      responseObject = [[[RPGQuestListResponse alloc]
                         initWithDictionaryRepresentation:responseDictionary] autorelease];
    }
    
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

- (void)doQuestAction:(RPGQuestAction)anAction
               byType:(RPGQuestType)aType
              request:(RPGQuestRequest *)aRequest
    completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback
{
  NSString *requestString = nil;
  
  switch (aType) {
    case kRPGQuestTypeSingle:
    {
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
      break;
    }
      
    case kRPGQuestTypeDuel:
    {
      switch (anAction)
      {
        case kRPGQuestActionTakeQuest:
        {
          requestString = [NSString stringWithFormat:@"%@%@",
                           kRPGNetworkManagerAPIHost,
                           kRPGNetworkManagerAPIAcceptDuelQuestRoute];
          break;
        }
          
        case kRPGQuestActionDeleteQuest:
        {
          requestString = [NSString stringWithFormat:@"%@%@",
                           kRPGNetworkManagerAPIHost,
                           kRPGNetworkManagerAPISkipDuelQuestRoute];
          break;
        }
      }
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

- (void)addProofByType:(RPGQuestType)aType
               request:(RPGQuestRequest *)aRequest
             imageData:(NSData *)anImageData
     completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback
{
  NSString *requestString = nil;
  
  switch (aType) {
    case kRPGQuestTypeSingle:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIProofQuestRoute];
      break;
    }
      
    case kRPGQuestTypeDuel:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIProofDuelQuestRoute];
      break;
    }
  }

  NSMutableURLRequest *request = [[[self requestWithObject:aRequest
                                                 URLstring:requestString
                                                    method:@"POST"] mutableCopy] autorelease];

    // build HTTP body
  NSString *boundary = @"---------------------------Boundary Line---------------------------";
  NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
  [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
  
  NSMutableData *body = [NSMutableData data];
  
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Disposition: form-data; name=\"json\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:request.HTTPBody];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Disposition: form-data; name=\"prove_image_1\"; filename=\"file.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:anImageData];
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
    // serialization error
    if (responseDictionary == nil)
    {
      [self  logError:JSONParsingError withTitle:@"JSON error"];
      
      dispatch_async(dispatch_get_main_queue(), ^
      {
        aCallback(kRPGStatusCodeNetworkManagerSerializingError);
      });
      return;
    }
    
    RPGBasicNetworkResponse *responseObject = [[[RPGBasicNetworkResponse alloc]
                                                initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
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

- (void)postQuestProofByType:(RPGQuestType)aType
                     request:(RPGQuestReviewRequest *)aRequest
           completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback
{
  NSString *requestString = nil;
  
  switch (aType)
  {
    case kRPGQuestTypeSingle:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIReviewResultQuestRoute];
      break;
    }
      
    case kRPGQuestTypeDuel:
    {
      requestString = [NSString stringWithFormat:@"%@%@",
                       kRPGNetworkManagerAPIHost,
                       kRPGNetworkManagerAPIReviewResultDuelQuestRoute];
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
      // serialization error
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

- (void)getQuestRewardWithRequest:(RPGQuestRequest *)aRequest
                completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIGetQuestRewardRoute];
  
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
    // serialization error
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
