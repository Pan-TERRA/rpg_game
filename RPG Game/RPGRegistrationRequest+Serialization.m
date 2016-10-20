//
//  RPGRegistrationRequest+Serialization.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRegistrationRequest+Serialization.h"

static NSString * const kRPGRegistrationRequestUsername = @"username";
static NSString * const kRPGRegistrationRequestEmail = @"email";
static NSString * const kRPGRegistrationRequestPassword = @"password";
static NSString * const kRPGRegistrationRequestCharacter = @"character";
static NSString * const kRPGRegistrationRequestCharacterName = @"name";
static NSString * const kRPGRegistrationRequestCharacterType = @"class_id";

@implementation RPGRegistrationRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGRegistrationRequestUsername] = self.username;
  dictionaryRepresentation[kRPGRegistrationRequestEmail] = self.email;
  dictionaryRepresentation[kRPGRegistrationRequestPassword] = self.password;
  dictionaryRepresentation[kRPGRegistrationRequestCharacter] = @{kRPGRegistrationRequestCharacterName : self.characterName,
                                                                 kRPGRegistrationRequestCharacterType : @(self.characterType)};
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithEmail:aDictionary[kRPGRegistrationRequestEmail]
                    password:aDictionary[kRPGRegistrationRequestPassword]
                    username:aDictionary[kRPGRegistrationRequestUsername]
               characterName:aDictionary[kRPGRegistrationRequestCharacterName]
               characterType:[aDictionary[kRPGRegistrationRequestCharacterType] integerValue]];
}

@end