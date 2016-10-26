//
//  RPGAuthorizationLogoutRequest+Serialization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLogoutRequest.h"
#import "RPGSerializable.h"

@interface RPGAuthorizationLogoutRequest (Serialization) <RPGSerializable>

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
