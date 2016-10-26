//
//  RPGNetworkManager+AuthorizationTests.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RPGAuthorizationLoginRequest.h"
#import "RPGStatusCodes.h"
#import "RPGNetworkManager+Authorization.h"

@interface RPGNetworkManager_AuthorizationTests : XCTestCase

@end

@implementation RPGNetworkManager_AuthorizationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogin_correctRequest_success
{
  XCTestExpectation *testExpectation = [self expectationWithDescription:@"finish block execution (needed for asyncronious testing)"];
  RPGNetworkManager *sharedNetworkManager = [RPGNetworkManager sharedNetworkManager];
  RPGAuthorizationLoginRequest *authorizationLoginRequest = [RPGAuthorizationLoginRequest authorizationRequestWithEmail:@"eleonora@gmail.com"
                                                                                                               password:@"eleonora"];
  [sharedNetworkManager loginWithRequest:authorizationLoginRequest completionHandler:^(NSInteger statusCode)
  {
    XCTAssertEqual(statusCode, kRPGStatusCodeOk);
    [testExpectation fulfill];
  }];
  [self waitForExpectationsWithTimeout:10 handler:nil];
}



@end
