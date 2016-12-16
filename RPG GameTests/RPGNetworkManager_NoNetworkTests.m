//
//  RPGNetworkManager_NoNetworkTests.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/29/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#define TIMEOUT 10
#define EMAIL "testblablabla@test.test"
#define PASSWORD "test"
#define USERNAME "ololo"
#define CHARACTERNAME "ololocreature"
#define TYPEID 1

#import <XCTest/XCTest.h>
#import "RPGAuthorizationLoginRequest.h"
#import "RPGBasicNetworkRequest.h"
#import "RPGRegistrationRequest.h"
#import "RPGNetworkManager+Authorization.h"
#import "RPGNetworkManager+Registration.h"
#import "RPGStatusCodes.h"

@interface RPGNetworkManager_NoNetworkTests : XCTestCase

@property RPGNetworkManager *sharedNetworkManager;

@end

@implementation RPGNetworkManager_NoNetworkTests

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

#pragma mark - Run these tests without network connection

- (void)testLogin
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  RPGAuthorizationLoginRequest *authorizationLoginRequest = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:@EMAIL
                                                                                                               password:@PASSWORD];
  [self.sharedNetworkManager loginWithRequest:authorizationLoginRequest
                            completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeNetworkManagerNoInternetConnection);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testLogout
{
  XCTestExpectation *logoutExpectation = [self expectationWithDescription:@"finish logout"];
  [self.sharedNetworkManager logoutWithCompletionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeNetworkManagerNoInternetConnection);
    [logoutExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

- (void)testRegister
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution"];
  RPGRegistrationRequest *registrationRequest = [RPGRegistrationRequest registrationRequestWithEmail:@EMAIL
                                                                                            password:@PASSWORD
                                                                                            username:@USERNAME
                                                                                       characterName:@CHARACTERNAME
                                                                                       characterType:TYPEID];
  [self.sharedNetworkManager registerWithRequest:registrationRequest
                               completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeNetworkManagerNoInternetConnection);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:TIMEOUT handler:nil];
}

@end
