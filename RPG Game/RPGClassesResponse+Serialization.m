//
//  RPGClassesResponse+Serialization.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGClassesResponse+Serialization.h"

static NSString * const kRPGClassesResposeStatus = @"status";
static NSString * const kRPGClassesResposeClasses = @"classes";

@implementation RPGClassesResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  dictionary[kRPGClassesResposeStatus] = @(self.status);
  dictionary[kRPGClassesResposeClasses] = self.classes;
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGClassesResposeStatus] integerValue]
                      classes:aDictionary[kRPGClassesResposeClasses]];
}

@end
