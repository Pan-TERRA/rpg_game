//
//  RPGNetworkManager+Quests.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Quests.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGQuestListResponse+Serialization.h"
#import "RPGQuestRequest+Serialization.h"
#import "RPGQuestResponse+Serialization.h"

@implementation RPGNetworkManager (Quests)

- (void)fetchQuestsByState:(RPGQuestListState)aState completionHandler:(void (^)(NSInteger status, NSArray *quests))callbackBlock
{
  NSString *requestString = nil;

  switch (aState)
  {
    case kRPGQuestListTakeQuest:
      requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/quests"];
      break;
      
    case kRPGQuestListInProgressQuest:
      requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/in_progress_quests"];
      break;
      
    case kRPGQuestListDoneQuest:
      requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/confirmed_quests"];
      break;
      
    case kRPGQuestListReviewQuest:
      requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/review_quests"];
      break;
 
    default:
      break;
  }
  
  NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]] autorelease];
  
  NSError *JSONSerializationError = nil;
  request.HTTPMethod = @"POST";
  
  NSDictionary *requestDictionary = @{ @"token" : [[NSUserDefaults standardUserDefaults] sessionToken] };
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestDictionary
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&JSONSerializationError];
  
  if (JSONSerializationError != nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from request"
                           userInfo:nil] raise];
  }
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
    NSInteger status = 0;
    NSError *JSONParsingError = nil;
    RPGQuestListResponse *responseObject = nil;
    
    if (error != nil)
    {
      status = 1;
    }
    
    if (data != nil)
    {
      NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&JSONParsingError];
      
      if (JSONParsingError != nil)
      {
          // ???: tramper question
        status = 3;
      }
      else
      {
        responseObject = [[[RPGQuestListResponse alloc]
                           initWithDictionaryRepresentation:responseDictionary] autorelease];
      }
      
    }
    else
    {
      status = 2;
    }
    
    if (responseObject == nil)
    {
      status = 4;
    }
    
    status = (status != 0) ? status : responseObject.status;
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(status, responseObject.quests);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)takeQuestWithRequest:(RPGQuestRequest *)aRequest completionHandler:(void (^)(NSInteger status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/accept_quest"];
  
  NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]] autorelease];
  
  NSError *JSONSerializationError = nil;
  request.HTTPMethod = @"POST";
  
  NSDictionary *requestDictionary = [aRequest dictionaryRepresentation];
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestDictionary
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&JSONSerializationError];
  
  if (JSONSerializationError != nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from request"
                           userInfo:nil] raise];
  }
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
    NSInteger status = 0;
    NSError *JSONParsingError = nil;
    RPGQuestResponse *responseObject = nil;
    
    if (error != nil)
    {
      status = 1;
    }
    
    if (data != nil)
    {
      NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&JSONParsingError];
      
      if (JSONParsingError != nil)
      {
        // ???: tramper question
        status = 3;
      }
      else
      {
        responseObject = [[[RPGQuestResponse alloc]
                           initWithDictionaryRepresentation:responseDictionary] autorelease];
      }
      
    }
    else
    {
      status = 2;
    }
    
    if (responseObject == nil)
    {
      status = 4;
    }
    
    status = (status != 0) ? status : responseObject.status;
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(status);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)addProofWithRequest:(RPGQuestRequest *)aRequest imageData:(NSData *)imageData completionHandler:(void (^)(NSInteger status))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/prove_quest"];
  
  NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]] autorelease];
  
  NSError *JSONSerializationError = nil;
  request.HTTPMethod = @"POST";
  
  NSDictionary *requestDictionary = [aRequest dictionaryRepresentation];
  NSData *requestJSONData = [NSJSONSerialization dataWithJSONObject:requestDictionary
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&JSONSerializationError];
  
  NSString *boundary = @"---------------------------Boundary Line---------------------------";
  NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
  [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
  
  NSMutableData *body = [[[NSMutableData alloc] init] autorelease];
  
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Disposition: form-data; name=\"json\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:requestJSONData];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Disposition: form-data; name=\"prove_image\"; filename=\"file.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [body appendData:imageData];
  [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

  request.HTTPBody = body;
  
  if (JSONSerializationError != nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from request"
                           userInfo:nil] raise];
  }
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
    NSInteger status = 0;
    NSError *JSONParsingError = nil;
    RPGQuestResponse *responseObject = nil;
    
    if (error != nil)
    {
      status = 1;
    }
    
    if (data != nil)
    {
      NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:&JSONParsingError];
      
      if (JSONParsingError != nil)
      {
        // ???: tramper question
        status = 3;
      }
      else
      {
        responseObject = [[[RPGQuestResponse alloc]
                           initWithDictionaryRepresentation:responseDictionary] autorelease];
      }
      
    }
    else
    {
      status = 2;
    }
    
    if (responseObject == nil)
    {
      status = 4;
    }
    
    status = (status != 0) ? status : responseObject.status;
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(status);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)getImageProofDataFromURL:(NSURL *)url completionHandler:(void (^)(NSData *imageData))callbackBlock
{
  
  NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
  
  request.HTTPMethod = @"GET";

  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data,
                                                              NSURLResponse * _Nullable response,
                                                              NSError * _Nullable error)
  {
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(data);
    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
