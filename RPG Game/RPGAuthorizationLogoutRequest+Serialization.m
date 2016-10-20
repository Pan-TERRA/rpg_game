//
//  RPGAuthorizationLogoutRequest+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLogoutRequest+Serialization.h"

static NSString * const kRPGAuthorizationLogoutRequestToken = @"token";

@implementation RPGAuthorizationLogoutRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAuthorizationLogoutRequestToken] = self.token;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithToken:aDictionary[kRPGAuthorizationLogoutRequestToken]];
}

@end