//
//  RPGResources.m
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResources.h"

NSString * const kRPGResourcesGold = @"gold";
NSString * const kRPGResourcesCrystals = @"crystals";

@interface RPGResources()

@property (nonatomic, assign, readwrite) NSInteger gold;
@property (nonatomic, assign, readwrite) NSInteger crystals;

@end

@implementation RPGResources

#pragma mark - Init

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
{
  self = [super init];
  
  if (self != nil)
  {
    if (aGold < 0 || aCrystals < 0)
    {
      [self release];
      self = nil;
    }
    else
    {
      _gold = aGold;
      _crystals = aCrystals;
    }
  }
  
  return self;
}

+ (instancetype)resourcesWithGold:(NSInteger)aGold
                         crystals:(NSInteger)aCrystals
{
  return [[[self alloc] initWithGold:aGold
                            crystals:aCrystals] autorelease];
}

- (instancetype)init
{
  return [self initWithGold:-1
                   crystals:-1];
}

#pragma mark - RPGSerializable

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
  
  return [self initWithGold:gold
                   crystals:crystals];
}

@end
