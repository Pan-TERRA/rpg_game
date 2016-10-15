//
//  RPGTimeResponse+Serialization.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse+Serialization.h"

static NSString *const kRPGTimeResponseSerializationTimestamp = @"time";

@implementation RPGTimeResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGTimeResponseSerializationTimestamp] = @([self.timestamp timeIntervalSince1970]);
  
  return [[dictionaryRepresentation copy] autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithUnixTimestamp:[aDictionary[kRPGTimeResponseSerializationTimestamp] intValue]];
}

@end
