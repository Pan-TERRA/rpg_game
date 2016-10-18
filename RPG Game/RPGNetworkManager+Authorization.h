//
//  RPGNetworkManager+Authorization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGAuthorizationLoginRequest+Serialization.h"
#import "RPGAuthorizationLoginResponse+Serialization.h"
#import "RPGAuthorizationLogoutRequest+Serialization.h"
#import "RPGAuthorizationLogoutResponse+Serialization.h"

@interface RPGNetworkManager (Authorization)

- (void)loginWithRequest:(RPGAuthorizationLoginRequest *)aRequest
       completionHandler:(void (^)(RPGAuthorizationLoginResponse *))callbackBlock;
- (void)logoutWithCompletionHandler:(void (^)(int))callbackBlock;

@end
