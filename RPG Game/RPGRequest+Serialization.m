//
//  RPGRequest+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest+Serialization.h"

NSString *const kRPGRequestSerializationType = @"type";
NSString *const kRPGRequestSerializationToken = @"token";

@implementation RPGRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGRequestSerializationType] = self.type;
  dictionaryRepresentation[kRPGRequestSerializationToken] = self.token;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithType:aDictionary[kRPGRequestSerializationType]
                      token:aDictionary[kRPGRequestSerializationToken]];
}

@end
