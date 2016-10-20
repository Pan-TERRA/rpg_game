//
//  RPGAuthorizationLoginRequest+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginRequest+Serialization.h"

static NSString * const kRPGAuthorizationLoginRequestEmail = @"email";
static NSString * const kRPGAuthorizationLoginRequestPassword = @"password";

@implementation RPGAuthorizationLoginRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAuthorizationLoginRequestEmail] = self.email;
  dictionaryRepresentation[kRPGAuthorizationLoginRequestPassword] = self.password;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithEmail:aDictionary[kRPGAuthorizationLoginRequestEmail]
                    password:aDictionary[kRPGAuthorizationLoginRequestPassword]];
}

@end