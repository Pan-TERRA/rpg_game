//
//  RPGShopBuyUnitRequest.m
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopBuyUnitRequest.h"

static NSString * const kRPGShopBuyUnitRequestUnitID = @"unit_id";

@implementation RPGShopBuyUnitRequest

#pragma mark - Init

- (instancetype)initWithShopUnitID:(NSInteger)aShopUnitID
{
  self = [super init];
  
  if (self != nil)
  {
    _shopUnitID = aShopUnitID;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithShopUnitID:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

  dictionary[kRPGShopBuyUnitRequestUnitID] = @(self.shopUnitID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithShopUnitID:[aDictionary[kRPGShopBuyUnitRequestUnitID] integerValue]];
}

@end
