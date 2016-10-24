//
//  RPGEntity+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGEntity+Serialization.h"

NSString * const kRPGEntityName = @"name";
NSString * const kRPGEntityHP = @"HP";

@implementation RPGEntity (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGEntityName] = self.name;
  dictionaryRepresentation[kRPGEntityHP] = @(self.HP);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithName:aDictionary[kRPGEntityName] HP:[aDictionary[kRPGEntityHP] integerValue]];
}


@end
