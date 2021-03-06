//
//  RPGNetworkManager+Authorization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Entities
@class RPGAuthorizationLoginRequest;

@interface RPGNetworkManager (Authorization)

- (void)loginWithRequest:(RPGAuthorizationLoginRequest *)aRequest
       completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;
- (void)logoutWithCompletionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

@end
