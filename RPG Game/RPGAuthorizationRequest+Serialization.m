//
//  RPGAuthorizationRequest+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationRequest+Serialization.h"

static NSString *const kRPGRequestSerializationType = @"type";
static NSString *const kRPGRequestSerializationToken = @"token";
static NSString *const kRPGRequestSerializationEmail = @"email";
static NSString *const kRPGRequestSerializationPassword = @"password";

@implementation RPGAuthorizationRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGRequestSerializationType] = self.type;
  dictionaryRepresentation[kRPGRequestSerializationToken] = self.token;
  dictionaryRepresentation[kRPGRequestSerializationEmail] = self.email;
  dictionaryRepresentation[kRPGRequestSerializationPassword] = self.password;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithEmail:aDictionary[kRPGRequestSerializationEmail]
                    password:aDictionary[kRPGRequestSerializationPassword]];
}

@end
