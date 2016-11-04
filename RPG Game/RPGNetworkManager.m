  //
  //  RPGNetworkManager.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/11/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGNetworkManager.h"
  // Misc
#import "RPGSerializable.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "NSObject+RPGErrorLog.h"
  // Constants
#import "RPGStatusCodes.h"

static RPGNetworkManager *sharedNetworkManager = nil;

#pragma mark - API constants

  // General
NSString * const kRPGNetworkManagerAPIHost = @"http://10.55.33.28:8000";
static NSString * const kRPGNetworkManagerAPITokenExistsRoute = @"/tokenexists";
  // Authorization
NSString * const kRPGNetworkManagerAPILoginRoute = @"/login";
NSString * const kRPGNetworkManagerAPISignoutRoute = @"/signout";
  // Registration
NSString * const kRPGNetworkManagerAPIRegisterRoute = @"/register";
  // Quests
NSString * const kRPGNetworkManagerAPIQuestsRoute = @"/quests";
NSString * const kRPGNetworkManagerAPIQuestsInProgressRoute = @"/in_progress_quests";
NSString * const kRPGNetworkManagerAPIConfirmedQuestsRoute = @"/confirmed_quests";
NSString * const kRPGNetworkManagerAPIReviewQuestsRoute = @"/review_quests";
NSString * const kRPGNetworkManagerAPIAcceptQuestRoute = @"/accept_quest";
NSString * const kRPGNetworkManagerAPISkipQuestRoute = @"/skip_quest";
NSString * const kRPGNetworkManagerAPIReviewResultQuestRoute = @"/review_result";
NSString * const kRPGNetworkManagerAPIProofQuestRoute = @"/prove_quest";
  // Skills
NSString * const kRPGNetworkManagerAPISkillsRoute = @"/skills";
NSString * const kRPGNetworkManagerAPISkillInfoRoute = @"/skill/";
  // Classes
NSString * const kRPGNetworkManagerAPIClassesRoute = @"/classes";
NSString * const kRPGNetworkManagerAPIClassInfoRoute = @"/class/";

#pragma mark -

@implementation RPGNetworkManager

#pragma mark - Init

- (id)init
{
  return [super init];
}

+ (id)sharedNetworkManager
{
  @synchronized (self)
  {
    if (sharedNetworkManager == nil)
    {
      sharedNetworkManager = [[super allocWithZone:NULL] init];
    }
  }
  
  return sharedNetworkManager;
}

#pragma mark - Singleton

+ (id)allocWithZone:(NSZone *)aZone
{
  return [[self sharedNetworkManager] retain];
}

- (id)copyWithZone:(NSZone *)aZone
{
  return self;
}

- (id)retain
{
  return self;
}

- (NSUInteger)retainCount
{
  return UINT_MAX;
}

- (oneway void)release
{
  
}

- (id)autorelease
{
  return self;
}


- (NSURLRequest *)requestWithObject:(nullable id)anObject URLstring:(NSString *)aString method:(NSString *)aMethod
{
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:aString]];
  request.HTTPMethod = aMethod;
  request.HTTPBody = nil;
  NSError *JSONSerializationError = nil;
  
  if (anObject != nil)
  {
    if ([anObject isKindOfClass:[NSDictionary class]])
    {
      request.HTTPBody = [NSJSONSerialization dataWithJSONObject:anObject
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&JSONSerializationError];
    }
    
    if ([anObject conformsToProtocol:@protocol(RPGSerializable)])
    {
      request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[anObject dictionaryRepresentation]
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&JSONSerializationError];
    }
    
    if (request.HTTPBody == nil)
    {
      [[NSException exceptionWithName:NSInvalidArgumentException
                               reason:@"JSON cannot be retrieved"
                             userInfo:nil] raise];
    }
    
  }
  
  return request;
}

#pragma mark - General Requests

- (void)requestIfCurrentTokenIsValidWithCompletionHandler:(void (^)(BOOL isValid))callbackBlock
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  
  if (token != nil)
  {
    NSString *requestString = [NSString stringWithFormat:@"%@%@",
                               kRPGNetworkManagerAPIHost,
                               kRPGNetworkManagerAPITokenExistsRoute];
    
    NSURLRequest *request = [self requestWithObject:@{ @"token": token }
                                          URLstring:requestString
                                             method:@"POST"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error)
      {
        BOOL result = NO;
        
        if (error == nil && data != nil)
        {
          NSError *JSONError = nil;
          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:&JSONError];
          if (responseDictionary != nil
              && responseDictionary[@"status"] != nil
              && [responseDictionary[@"status"] integerValue] == 0)
          {
            result = YES;
          }
          else
          {
            [self logError:JSONError withTitle:@"JSON parsing error"];
          }
        }
        else
        {
          [self logError:error withTitle:@"Network error"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
          callbackBlock(result);
        });
        
      }];
    
    [task resume];
    [session finishTasksAndInvalidate];
  }
  else
  {
    callbackBlock(NO);
  }
}

@end
