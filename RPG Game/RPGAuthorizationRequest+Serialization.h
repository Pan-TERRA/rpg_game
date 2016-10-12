//
//  RPGAuthorizationRequest+Serialization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationRequest.h"

@interface RPGAuthorizationRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
