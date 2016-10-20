//
//  RPGNetworkManager+Registration.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager+Registration.h"
#import "RPGRegistrationRequest+Serialization.h"

@implementation RPGNetworkManager (Registration)

- (void)registerWithRequest:(RPGRegistrationRequest *)aRequest
          completionHandler:(void (^)(NSInteger))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/register"];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:0];
   NSError *JSONSerializationError = nil;
  request.HTTPMethod = @"POST";
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[aRequest dictionaryRepresentation]
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
  
  if (JSONSerializationError != nil)
  {
    [[NSException exceptionWithName:NSInvalidArgumentException
                             reason:@"JSON cannot be retrieved from register request"
                           userInfo:nil] raise];
  }
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error)
  {
    NSDictionary *responseDictionary = nil;
    NSInteger status = 0;
    NSError *JSONParsingError = nil;

    if (error != nil)
    {
      status = 1;
    }
    
    if (data != nil)
    {
      responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:&JSONParsingError];
      
      if (JSONParsingError != nil)
      {
          // ???: tramper question
        status = 3;
      }
      else
      {
        
      }
    }
    else
    {
      status = 2;
    }
    
    status = (status != 0) ? status : [responseDictionary[@"status"] integerValue];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
      callbackBlock(status);

    });
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end