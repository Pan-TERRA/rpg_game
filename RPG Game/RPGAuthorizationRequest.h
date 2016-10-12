//
//  RPGAuthorizationRequest.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"

@interface RPGAuthorizationRequest : RPGRequest

@property (copy, nonatomic, readonly) NSString *email;
@property (copy, nonatomic, readonly) NSString *password;

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword;
+ (instancetype)authorizationRequestWithEmail:(NSString *)anEmail
                                     password:(NSString *)aPassword;

@end
