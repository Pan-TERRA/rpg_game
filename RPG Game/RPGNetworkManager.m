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
  // Entities
#import "RPGResourcesResponse.h"
  // Constants
#import "RPGStatusCodes.h"

NSString * const kRPGRequestToken = @"token";

NSString * const kRPGNetworkManagerStatus = @"status";

static RPGNetworkManager *sharedNetworkManager = nil;



#pragma mark - API constants

  // General
NSString * const kRPGNetworkManagerAPIHost = @"http://10.55.33.28:8000";
static NSString * const kRPGNetworkManagerAPITokenExistsRoute = @"/token_exists";
  // Resources
static NSString * const kRPGNetworkManagerAPIResourcesRoute = @"/resources";

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
NSString * const kRPGNetworkManagerAPISelectSkillsRoute = @"/select_skills";
  // Classes
NSString * const kRPGNetworkManagerAPIClassesRoute = @"/classes";
NSString * const kRPGNetworkManagerAPIClassInfoRoute = @"/class/";
  // Character Profile
NSString * const kRPGNetworkManagerAPICharacterProfileInfoRoute = @"/char_profile";
  // Arena
NSString * const kRPGNetworkManagerAPIArenaSkillsRoute = @"/arena_skills";
NSString * const kRPGNetworkManagerAPIArenaPayRoute = @"/arena_pay";

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


- (NSURLRequest *)requestWithObject:(nullable id)anObject URLstring:(NSString *)aString method:(NSString *)aMethod injectToken:(BOOL)injectToken
{
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:aString]];
  request.HTTPMethod = aMethod;
  request.HTTPBody = nil;
  NSError *JSONSerializationError = nil;
  
  // ? ніл обєкт без токену
  if (anObject != nil)
  {
    NSMutableDictionary *JSONObject = nil;
    
    if ([anObject isKindOfClass:[NSDictionary class]])
    {
      JSONObject = [anObject mutableCopy];
    }
    else if ([anObject conformsToProtocol:@protocol(RPGSerializable)])
    {
      JSONObject = [[anObject dictionaryRepresentation] mutableCopy];
    }
    
    if (injectToken)
    {
      NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
      if (token != nil)
      {
        JSONObject[kRPGRequestToken] = token;
      }
    }
    
    [JSONObject autorelease];
    
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:JSONObject
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&JSONSerializationError];
    
    if (request.HTTPBody == nil || JSONSerializationError)
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
        BOOL result = NO;
        
        if (error == nil && data != nil)
        {
          NSError *JSONError = nil;
          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:&JSONError];

          if (responseDictionary == nil)
          {
            [self logError:JSONError withTitle:@"JSON parsing error"];
          }
          else if ([responseDictionary[@"status"] integerValue] == 0)
          {
            result = YES;
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
  else // if no token
  {
    callbackBlock(NO);
  }
}

- (void)getResourcesWithCompletionHandler:(void (^)(NSInteger aStatus, RPGResources *aResources))callbackBlock
{
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             kRPGNetworkManagerAPIResourcesRoute];
  
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
    
    RPGResourcesResponse *responseObject = nil;
    responseObject = [[[RPGResourcesResponse alloc]
                       initWithDictionaryRepresentation:responseDictionary] autorelease];
    // validation error
    if (responseObject == nil)
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(kRPGStatusCodeNetworkManagerResponseObjectValidationFail, nil);
      });
    }
    else
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        callbackBlock(responseObject.status, responseObject.resources);
      });
    }
  }];
  
  [task resume];
  
  [session finishTasksAndInvalidate];
}

- (void)getImageDataFromPath:(NSString *)aPath completionHandler:(void (^)(NSInteger aStatusCode, NSData *anImageData))callbackBlock
{
  NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",
                                          kRPGNetworkManagerAPIHost,
                                          aPath]];
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
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

- (BOOL)isNoInternerConnection:(NSError *)anError
{
  return ([anError.domain isEqualToString:NSURLErrorDomain] && anError.code == NSURLErrorNotConnectedToInternet);
}

- (BOOL)isResponseCodeNot200:(NSURLResponse *)aResponse
{
  NSInteger responseStatusCode = [(NSHTTPURLResponse *)aResponse statusCode];
  return responseStatusCode != 200;
}

@end
