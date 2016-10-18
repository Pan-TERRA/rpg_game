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

- (void)registerWithRequest:(RPGRegistrationRequest *)aRequest completionHandler:(void (^)(int))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@", @"http://10.55.33.28:8000/register"];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:0];
  
  request.HTTPMethod = @"POST";
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[aRequest dictionaryRepresentation]
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
  
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.networkServiceType = NSURLNetworkServiceTypeDefault;
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error)
                                {
                                  
                                  NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                     options:0
                                                                                                       error:nil];
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^
                                                 {
                                                   callbackBlock([responseDictionary[@"status"] intValue]);
                                                 });
                                }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

@end
