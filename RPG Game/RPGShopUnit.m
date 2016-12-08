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

static NSString * const sRPGShopUnitTypeGold = @"gold";
static NSString * const sRPGShopUnitTypeCrystall = @"crystals";
static NSString * const sRPGShopUnitTypeActiveSlot = @"active_slot";
static NSString * const sRPGShopUnitTypeBagSlot = @"bag_slots";
static NSString * const sRPGShopUnitTypeSkill = @"skill";

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
  
  NSString *shopUnitType = nil;
  
  if (self.unitType == kRPGShopUnitTypeGold)
  {
    shopUnitType = sRPGShopUnitTypeGold;
  }
  else if (self.unitType == kRPGShopUnitTypeBagSlot)
  {
    shopUnitType = sRPGShopUnitTypeBagSlot;
  }
  else if (self.unitType == kRPGShopUnitTypeActiveSlot)
  {
    shopUnitType = sRPGShopUnitTypeActiveSlot;
  }
  else if (self.unitType == kRPGShopUnitTypeSkill)
  {
    shopUnitType = sRPGShopUnitTypeSkill;
  }

  dictionary[kRPGShopUnitUnitType] = shopUnitType;
  
  dictionary[kRPGShopUnitUnitCount] = @(self.unitCount);
  
  NSString *priceType = nil;
  
  if (self.priceType == kRPGShopUnitPriceTypeGold)
  {
    priceType = sRPGShopUnitTypeGold;
  }
  else if (self.priceType == kRPGShopUnitPriceTypeCrystals)
  {
    priceType = sRPGShopUnitTypeCrystall;
  }
  
  dictionary[kRPGShopUnitPriceType] = priceType;
  
  dictionary[kRPGShopUnitPriceCount] = @(self.priceCount);
  dictionary[kRPGShopUnitSkillID] = @(self.skillID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  RPGShopUnitType unitType = kRPGShopUnitTypeGold;
  NSString *currentUnitType = aDictionary[kRPGShopUnitUnitType];
  if ([currentUnitType isEqualToString:sRPGShopUnitTypeBagSlot])
  {
    unitType = kRPGShopUnitTypeBagSlot;
  }
  else if ([currentUnitType isEqualToString:sRPGShopUnitTypeActiveSlot])
  {
    unitType = kRPGShopUnitTypeActiveSlot;
  }
  else if ([currentUnitType isEqualToString:sRPGShopUnitTypeSkill])
  {
    unitType = kRPGShopUnitTypeSkill;
  }
  
  RPGShopUnitPriceType priceType = kRPGShopUnitPriceTypeGold;
  if ([aDictionary[kRPGShopUnitPriceType] isEqualToString:sRPGShopUnitTypeCrystall])
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
