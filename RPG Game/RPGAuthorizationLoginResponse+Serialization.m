//
//  RPGAuthorizationLoginResponse+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse+Serialization.h"

static NSString * const kRPGAuthorizationLoginResponseStatus = @"status";
static NSString * const kRPGAuthorizationLoginResponseUsername = @"username";
static NSString * const kRPGAuthorizationLoginResponseToken = @"token";
static NSString * const kRPGAuthorizationLoginResponseAvatar = @"avatar";
static NSString * const kRPGAuthorizationLoginResponseGold = @"gold";
static NSString * const kRPGAuthorizationLoginResponseCrystals = @"crystals";
static NSString * const kRPGAuthorizationLoginResponseCharacter = @"character";

@implementation RPGAuthorizationLoginResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAuthorizationLoginResponseStatus] = @(self.status);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseUsername] = self.username;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseToken] = self.token;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseAvatar] = self.avatar;
  dictionaryRepresentation[kRPGAuthorizationLoginResponseGold] = @(self.gold);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseCrystals] = @(self.crystals);
  dictionaryRepresentation[kRPGAuthorizationLoginResponseCharacter] = self.character;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithUsername:aDictionary[kRPGAuthorizationLoginResponseUsername]
                          token:aDictionary[kRPGAuthorizationLoginResponseToken]
                         avatar:aDictionary[kRPGAuthorizationLoginResponseAvatar]
                           gold:[aDictionary[kRPGAuthorizationLoginResponseGold] integerValue]
                       crystals:[aDictionary[kRPGAuthorizationLoginResponseCrystals] integerValue]
                     character:aDictionary[kRPGAuthorizationLoginResponseCharacter]
                         status:[aDictionary[kRPGAuthorizationLoginResponseStatus] integerValue]];
}

@end
