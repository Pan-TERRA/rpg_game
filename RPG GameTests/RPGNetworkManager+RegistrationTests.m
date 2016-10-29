//
//  RPGNetworkManager+RegistrationTests.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#define TIMEOUT 10
#define EMAIL "ololo@gmail.com"
#define USERNAME "ololo"
#define PASSWORD "ololopass"
#define CHARACTERNAME "ololocreature"
#define TYPEID 1
#define DELETEROUTE "/deleteuser"

#import <XCTest/XCTest.h>
#import "RPGStatusCodes.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGNetworkManager+Registration.h"
#import "RPGNetworkManager+Authorization.h"
#import "RPGRegistrationRequest.h"
#import "RPGAuthorizationLoginRequest.h"

@interface RPGNetworkManager_RegistrationTests : XCTestCase

@property RPGNetworkManager *sharedNetworkManager;

@end

@implementation RPGNetworkManager_RegistrationTests

- (void)setUp
{
  [super setUp];
  self.sharedNetworkManager = [RPGNetworkManager sharedNetworkManager];
}

- (void)tearDown
{
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)deleteUser
{
  [self login];
  NSString *requestString = [NSString stringWithFormat:@"%@%@",
                             kRPGNetworkManagerAPIHost,
                             @DELETEROUTE];
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  NSDictionary *requestDictionary = @{@"token" : token};
  NSURLRequest *request = [self.sharedNetworkManager requestWithObject:requestDictionary
                                                             URLstring:requestString
                                                                method:@"POST"];
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data,
                                                              NSURLResponse *response,
                                                              NSError *error){}];
  [task resume];
  [session finishTasksAndInvalidate];
}

- (void)login
{
  RPGAuthorizationLoginRequest *loginRequest = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:@EMAIL
                                                                                                  password:@PASSWORD];
  [self.sharedNetworkManager loginWithRequest:loginRequest
                            completionHandler:^(NSInteger statusCode){}];
}

- (void)registerWithCompletionHandler:(void (^)(NSInteger))callbackBlock
{
  RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:@EMAIL
                                                                                            password:@PASSWORD
                                                                                            username:@USERNAME
                                                                                       characterName:@CHARACTERNAME
                                                                                       characterType:TYPEID];
  [self.sharedNetworkManager registerWithRequest:registrationRequest
                               completionHandler:callbackBlock];
}

- (void)test_sendCorrectRequest_successCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  [self deleteUser];
  [self registerWithCompletionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeOk);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)test_sendWrongEmailFormat_wrondEmailCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:@"sdalfjksdf"
                                                                                            password:@PASSWORD
                                                                                            username:@USERNAME
                                                                                       characterName:@CHARACTERNAME
                                                                                       characterType:TYPEID];
  [self.sharedNetworkManager registerWithRequest:registrationRequest
                               completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeWrongEmail);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)test_sendExistingEmail_emailIsAlreadyTakenCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  [self deleteUser];
  [self registerWithCompletionHandler:^(NSInteger statusCode){}];
  RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:@EMAIL
                                                                                            password:@PASSWORD
                                                                                            username:@"sadfhlj"
                                                                                       characterName:@CHARACTERNAME
                                                                                       characterType:TYPEID];
  [self.sharedNetworkManager registerWithRequest:registrationRequest
                               completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeEmailIsAlreadyTaken);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)test_sendExistingUsername_usernameIsAlreadyTakenCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  [self deleteUser];
  [self registerWithCompletionHandler:^(NSInteger statusCode){}];
  RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:@"afsd@asfoih.com"
                                                                                            password:@PASSWORD
                                                                                            username:@USERNAME
                                                                                       characterName:@CHARACTERNAME
                                                                                       characterType:TYPEID];
  [self.sharedNetworkManager registerWithRequest:registrationRequest
                               completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeUsernameIsAlreadyTaken);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

@end
