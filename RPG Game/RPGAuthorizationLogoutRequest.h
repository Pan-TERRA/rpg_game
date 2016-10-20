//
//  RPGAuthorizationLogoutRequest.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGAuthorizationLogoutRequest : NSObject

@property (nonatomic, copy, readonly) NSString *token;

- (instancetype)initWithToken:(NSString *)aToken NS_DESIGNATED_INITIALIZER;
+ (instancetype)requestWithToken:(NSString *)aToken;

@end
