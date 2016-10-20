//
//  RPGRegistrationRequest+Serialization.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRegistrationRequest.h"

@interface RPGRegistrationRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end