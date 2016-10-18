//
//  RPGAuthorizationLoginResponse+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse+Serialization.h"

NSString * const kRPGAuthorizationLoginResponseUsername = @"username";
NSString * const kRPGAuthorizationLoginResponseToken = @"token";
NSString * const kRPGAuthorizationLoginResponseAvatar = @"avatar";
NSString * const kRPGAuthorizationLoginResponseGold = @"gold";
NSString * const kRPGAuthorizationLoginResponseCrystals = @"crystals";
NSString * const kRPGAuthorizationLoginResponseCharacters = @"characters";

@implementation RPGAuthorizationLoginResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAuthorizationLoginResponseUsername] = self.username;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseToken] = self.token;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseAvatar] = self.avatar;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseGold] = @(self.gold);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseCrystals] = @(self.crystals);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseCharacters] = [NSArray array];
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithUsername:aDictionary[kRPGAuthorizationLoginResponseUsername]
                          token:aDictionary[kRPGAuthorizationLoginResponseToken]
                         avatar:aDictionary[kRPGAuthorizationLoginResponseAvatar]
                           gold:[aDictionary[kRPGAuthorizationLoginResponseGold] integerValue]
                       crystals:[aDictionary[kRPGAuthorizationLoginResponseCrystals] integerValue]
                     characters:aDictionary[kRPGAuthorizationLoginResponseCharacters]];
}

@end
