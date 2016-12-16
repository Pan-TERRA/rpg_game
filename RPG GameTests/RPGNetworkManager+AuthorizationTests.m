//
//  RPGNetworkManager+AuthorizationTests.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#define TIMEOUT 10
#define EMAIL "testblablabla@test.test"
#define PASSWORD "test"
#define USERNAME "test"
#define CHARACTERNAME "test"

#import <XCTest/XCTest.h>
#import "RPGAuthorizationLoginRequest.h"
#import "RPGRegistrationRequest.h"
#import "RPGStatusCodes.h"
#import "RPGNetworkManager+Authorization.h"
#import "RPGNetworkManager+Registration.h"
#import "NSUserDefaults+RPGSessionInfo.h"

@interface RPGNetworkManager_AuthorizationTests : XCTestCase

@property RPGNetworkManager *sharedNetworkManager;

@end

@implementation RPGNetworkManager_AuthorizationTests

- (void)setUp
{
  [super setUp];
  self.sharedNetworkManager = [RPGNetworkManager sharedNetworkManager];
  [self registerUser];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)registerUser
{
  XCTestExpectation *registrationExpectation = [self expectationWithDescription:@"finish registration"];
  RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:@EMAIL
                                                                                            password:@PASSWORD
                                                                                            username:@USERNAME
                                                                                       characterName:@CHARACTERNAME
                                                                                       characterType:1];
  [self.sharedNetworkManager registerWithRequest:registrationRequest completionHandler:^(NSInteger statusCode)
  {
    if (statusCode != kRPGStatusCodeOK &&
        statusCode != kRPGStatusCodeEmailAlreadyTaken &&
        statusCode != kRPGStatusCodeUsernameAlreadyTaken)
    {
      XCTFail(@"could not register: status code %ld", (long)statusCode);
    }
    [registrationExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
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
    XCTAssertEqual(statusCode, kRPGStatusCodeOK);
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
    XCTAssertEqual(statusCode, kRPGStatusCodeOK);
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
