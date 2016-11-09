//
//  RPGResourcesResponse+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResourcesResponse+Serialization.h"
#import "RPGResources+Serialization.h"

NSString * const kRPGResourcesResponseStatus = @"status";
NSString * const kRPGResourcesResponseResources = @"resources";

@implementation RPGResourcesResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGResourcesResponseStatus] = @(self.status);
  dictionaryRepresentation[kRPGResourcesResponseResources] = [self.resources dictionaryRepresentation];
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSInteger status = [aDictionary[kRPGResourcesResponseStatus] integerValue];
  RPGResources *resources = [[[RPGResources alloc] initWithDictionaryRepresentation:aDictionary[kRPGResourcesResponseResources]] autorelease];
  
  return [self initWithStatus:status resources:resources];
}

@end
