//
//  RPGShopUnit.m
//  RPG Game
//
//  Created by Владислав Крут on 11/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGShopUnit.h"

NSString * const kRPGShopUnitUnitName = @"unit_name";
NSString * const kRPGShopUnitUnitID = @"unit_id";
NSString * const kRPGShopUnitUnitType = @"unit_type";
NSString * const kRPGShopUnitUnitCount = @"unit_count";
NSString * const kRPGShopUnitPriceType = @"price_type";
NSString * const kRPGShopUnitPriceCount = @"unit_price";
NSString * const kRPGShopUnitSkillID = @"skill_id";

@implementation RPGShopUnit

#pragma mark - Init

- (instancetype)initWithUnitName:(NSString *)aUnitName
                          unitID:(NSInteger)aUnitID
                        unitType:(RPGShopUnitType)aUnitType
                       unitCount:(NSInteger)aUnitCount
                       priceType:(RPGShopUnitPriceType)aPriceType
                      priceCount:(NSInteger)aPriceCount
                         skillID:(NSInteger)aSkillID
{
  self = [super init];
  if (self)
  {
    _unitName = [aUnitName copy];
    _unitID = aUnitID;
    _unitType = aUnitType;
    _unitCount = aUnitCount;
    _priceType = aPriceType;
    _priceCount = aPriceCount;
    _skillID = aSkillID;
  }
  return self;
}

+ (instancetype)shopUnitWithUnitName:(NSString *)aUnitName
                              unitID:(NSInteger)aUnitID
                            unitType:(RPGShopUnitType)aUnitType
                           unitCount:(NSInteger)aUnitCount
                           priceType:(RPGShopUnitPriceType)aPriceType
                          priceCount:(NSInteger)aPriceCount
                             skillID:(NSInteger)aSkillID
{
  return [[[self alloc] initWithUnitName:aUnitName
                                  unitID:aUnitID
                                unitType:aUnitType
                               unitCount:aUnitCount
                               priceType:aPriceType
                              priceCount:aPriceCount
                                 skillID:aSkillID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_unitName release];
  
  [super dealloc];
}

#pragma mark - RPGSerializeble
  //TODO: redo this shit

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  dictionary[kRPGShopUnitUnitName] = self.unitName;
  dictionary[kRPGShopUnitUnitID] = @(self.unitID);
  
  if (self.unitType == kRPGShopUnitTypeGold)
  {
    dictionary[kRPGShopUnitUnitType] = @"gold";
  } else if (self.unitType == kRPGShopUnitTypeBagSlot)
  {
    dictionary[kRPGShopUnitUnitType] = @"bag_slots";
  }
  else if (self.unitType == kRPGShopUnitTypeActiveSlot)
  {
    dictionary[kRPGShopUnitUnitType] = @"active_slot";
  }
  else if (self.unitType == kRPGShopUnitTypeSkill)
  {
    dictionary[kRPGShopUnitUnitType] = @"skill";
  }
  
  dictionary[kRPGShopUnitUnitCount] = @(self.unitCount);
  
  if (self.priceType == kRPGShopUnitPriceTypeGold)
  {
    dictionary[kRPGShopUnitPriceType] = @"gold";
  }
  else if (self.priceType == kRPGShopUnitPriceTypeCrystals)
  {
    dictionary[kRPGShopUnitPriceType] = @"crystals";
  }
  
  dictionary[kRPGShopUnitPriceCount] = @(self.priceCount);
  dictionary[kRPGShopUnitSkillID] = @(self.skillID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGShopUnitType unitType = kRPGShopUnitTypeGold;
  if ([aDictionary[kRPGShopUnitUnitType] isEqualToString:@"bag_slots"])
  {
    unitType = kRPGShopUnitTypeBagSlot;
  }
  else if ([aDictionary[kRPGShopUnitUnitType] isEqualToString:@"active_slot"])
  {
    unitType = kRPGShopUnitTypeActiveSlot;
  }
  else if ([aDictionary[kRPGShopUnitUnitType] isEqualToString:@"skill"])
  {
    unitType = kRPGShopUnitTypeSkill;
  }
  
  RPGShopUnitPriceType priceType = kRPGShopUnitPriceTypeGold;
  if ([aDictionary[kRPGShopUnitPriceType] isEqualToString:@"crystals"])
  {
    priceType = kRPGShopUnitPriceTypeCrystals;
  }
  
  return [self initWithUnitName:aDictionary[kRPGShopUnitUnitName]
                         unitID:[aDictionary[kRPGShopUnitUnitID] integerValue]
                       unitType:unitType
                      unitCount:[aDictionary[kRPGShopUnitUnitCount] integerValue]
                      priceType:priceType
                     priceCount:[aDictionary[kRPGShopUnitPriceCount] integerValue]
                        skillID:[aDictionary[kRPGShopUnitSkillID] integerValue]];
}
@end
