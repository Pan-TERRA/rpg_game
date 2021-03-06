//
//  RPGShopUnitsResponse.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopUnitsResponse.h"

static NSString * const kRPGShopUnitsResponseStatus = @"status";
static NSString * const kRPGShopUnitsResponseUnits = @"shop_units";

@implementation RPGShopUnitsResponse

#pragma mark - Init

- (instancetype)init
{
  return [self initWithStatus:-1
                    shopUnits:nil];
}

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                     shopUnits:(NSArray<NSDictionary *> *)aShopUnits
{
  self = [super init];
  
  if (self != nil)
  {
    _status = aStatus;
    if (aShopUnits == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _shopUnits = [aShopUnits retain];
    }
  }
  
  return self;
}

+ (instancetype)shopUnitResponseWithStatus:(RPGStatusCode)aStatus
                                 shopUnits:(NSArray<NSDictionary *> *)aShopUnits
{
  return [[[self alloc] initWithStatus:aStatus
                             shopUnits:aShopUnits] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_shopUnits release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGShopUnitsResponseStatus] = @(self.status);
  if (self.shopUnits != nil)
  {
    dictionary[kRPGShopUnitsResponseUnits] = self.shopUnits;
  }
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGShopUnitsResponseStatus] integerValue]
                    shopUnits:aDictionary[kRPGShopUnitsResponseUnits]];
}

@end
