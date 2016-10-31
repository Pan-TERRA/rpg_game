//
//  RPGNetworkManager+AuthorizationTests.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#define TIMEOUT 10
#define EMAIL "eleonora@gmail.com"
#define PASSWORD "eleonora"

#import <XCTest/XCTest.h>
#import "RPGAuthorizationLoginRequest.h"
#import "RPGAuthorizationLogoutRequest.h"
#import "RPGStatusCodes.h"
#import "RPGNetworkManager+Authorization.h"
#import "NSUserDefaults+RPGSessionInfo.h"

@interface RPGNetworkManager_AuthorizationTests : XCTestCase

@property RPGNetworkManager *sharedNetworkManager;

@end

@implementation RPGNetworkManager_AuthorizationTests

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

- (void)loginWithCompletionHandler:(void (^)(NSInteger))callbackBlock
{
  RPGAuthorizationLoginRequest *authorizationLoginRequest = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:@EMAIL
                                                                                                               password:@PASSWORD];
  [self.sharedNetworkManager loginWithRequest:authorizationLoginRequest
                            completionHandler:callbackBlock];
}

- (void)test_requestSharedNetworkManager_correctInstanseReturned
{
  XCTAssertEqualObjects([self.sharedNetworkManager class], [RPGNetworkManager class]);
}

- (void)testLogin_sendCorrectRequest_successCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution (needed for asyncronious testing)"];
  [self loginWithCompletionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeOk);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testLogin_sendWrongEmailFormat_wrondEmailCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  RPGAuthorizationLoginRequest *authorizationLoginRequest = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:@"kjnlwkjbwq"
                                                                                                               password:@PASSWORD];
  [self.sharedNetworkManager loginWithRequest:authorizationLoginRequest
                            completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeWrongEmail);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testLogin_sendWrongEmail_userDoesNotExistCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  RPGAuthorizationLoginRequest *authorizationLoginRequest = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:@"dsaf@hvsiu.wfjj"
                                                                                                               password:@PASSWORD];
  [self.sharedNetworkManager loginWithRequest:authorizationLoginRequest
                            completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeUserDoesNotExist);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testLogin_sendWrongPassword_wrongPasswordCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  RPGAuthorizationLoginRequest *authorizationLoginRequest = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:@EMAIL
                                                                                                               password:@"ohwwhfhj"];
  [self.sharedNetworkManager loginWithRequest:authorizationLoginRequest
                            completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeWrongPassword);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testLogout_sendCorrectRequest_successCodeReturned
{
  XCTestExpectation *loginExpectation = [self expectationWithDescription:@"finish login"];
  [self loginWithCompletionHandler:^(NSInteger statusCode)
  {
    [loginExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
  
  XCTestExpectation *logoutExpectation = [self expectationWithDescription:@"finish logout"];
  [self.sharedNetworkManager logoutWithCompletionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeOk);
    [logoutExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testLogout_sendWrongToken_wrongTokenCodeReturned
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  [NSUserDefaults standardUserDefaults].sessionToken = @"lololoBO9UPNXkeJh0PV9fKYCCaS-SNI5wZ9NUvwbKM";
  [self.sharedNetworkManager logoutWithCompletionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeWrongToken);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

@end
