//
//  RPGAuthorizationLoginResponse+Serialization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse.h"

extern NSString * const kRPGAuthorizationLoginResponseUsername;
extern NSString * const kRPGAuthorizationLoginResponseToken;
extern NSString * const kRPGAuthorizationLoginResponseAvatar;
extern NSString * const kRPGAuthorizationLoginResponseGold;
extern NSString * const kRPGAuthorizationLoginResponseCrystals;
extern NSString * const kRPGAuthorizationLoginResponseCharacters;

@interface RPGAuthorizationLoginResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
