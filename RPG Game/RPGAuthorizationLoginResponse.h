  //
  //  RPGAuthorizationLoginResponse.h
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/13/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"
  // Constants
#import "RPGStatusCodes.h"

@interface RPGAuthorizationLoginResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) RPGStatusCode status;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, retain, readonly) NSDictionary *character;

#pragma mark - Init

- (instancetype)initWithUsername:(NSString *)aUsername
                           token:(NSString *)aToken
                       character:(NSDictionary *)aCharacter
                          status:(RPGStatusCode)aStatus NS_DESIGNATED_INITIALIZER;

+ (instancetype)responseWithUsername:(NSString *)aUsername
                               token:(NSString *)aToken
                           character:(NSDictionary *)aCharacter
                              status:(RPGStatusCode)aStatus;

#pragma mark - Actions

- (void)store;

@end
