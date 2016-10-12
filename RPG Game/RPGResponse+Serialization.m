//
//  RPGResponse+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse+Serialization.h"

static NSString *const kRPGResponseSerializationType = @"type";

@implementation RPGResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGResponseSerializationType] = self.type;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithType:aDictionary[kRPGResponseSerializationType]];
}



@end
