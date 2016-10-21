//
//  RPGQuestResponse+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestResponse+Serialization.h"

static NSString * const kRPGQuestResponseStatus = @"status";

@implementation RPGQuestResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGQuestResponseStatus] = @(self.status);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGQuestResponseStatus] integerValue]];
}

@end
