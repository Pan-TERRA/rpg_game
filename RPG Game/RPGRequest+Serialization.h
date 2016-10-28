//
//  RPGRequest+Serialization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"
#import "RPGSerializable.h"

extern NSString *const kRPGRequestSerializationType;
extern NSString *const kRPGRequestSerializationToken;

@interface RPGRequest (Serialization) <RPGSerializable>

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
