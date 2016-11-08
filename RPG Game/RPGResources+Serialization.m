//
//  RPGResources+Serialization.m
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResources+Serialization.h"

NSString * const kRPGResourcesGold = @"gold";
NSString * const kRPGResourcesCrystals = @"crystals";

@implementation RPGResources (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGResourcesGold] = @(self.gold);
  dictionaryRepresentation[kRPGResourcesCrystals] = @(self.crystals);
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSUInteger gold = [aDictionary[kRPGResourcesGold] integerValue];
  NSUInteger crystals = [aDictionary[kRPGResourcesCrystals] integerValue];
  
  return [self initWithGold:gold crystals:crystals];
}

@end
