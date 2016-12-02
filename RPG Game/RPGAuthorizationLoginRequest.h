//
//  RPGAuthorizationLoginRequest.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGAuthorizationLoginRequest : NSObject <RPGSerializable>

@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *password;

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword NS_DESIGNATED_INITIALIZER;
+ (instancetype)authorizationRequestWithEmail:(NSString *)anEmail
                                     password:(NSString *)aPassword;

@end
