//
//  RPGShopUnit.h
//  RPG Game
//
//  Created by Владислав Крут on 11/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

typedef NS_ENUM(NSUInteger, RPGShopUnitPriceType)
{
  kRPGShopUnitPriceTypeGold,
  kRPGShopUnitPriceTypeCrystals
};

typedef NS_ENUM(NSUInteger, RPGShopUnitType)
{
  kRPGShopUnitTypeGold,
  kRPGShopUnitTypeBagSlot,
  kRPGShopUnitTypeActiveSlot,
  kRPGShopUnitTypeSkill
};

@interface RPGShopUnit : NSObject <RPGSerializable>

@property (copy, readonly, nonatomic) NSString *unitName;
@property (assign, readonly, nonatomic) NSInteger unitID;
@property (assign, readonly, nonatomic) RPGShopUnitType unitType;
@property (assign, readonly, nonatomic) NSInteger unitCount;
@property (assign, readonly, nonatomic) RPGShopUnitPriceType priceType;
@property (assign, readonly, nonatomic) NSInteger priceCount;
@property (assign, readonly, nonatomic) NSInteger skillID;

- (instancetype)initWithUnitName:(NSString *)aUnitName
                          unitID:(NSInteger)aUnitID
                        unitType:(RPGShopUnitType)aUnitType
                       unitCount:(NSInteger)aUnitCount
                       priceType:(RPGShopUnitPriceType)aPriceType
                      priceCount:(NSInteger)aPriceCount
                         skillID:(NSInteger)aSkillID;

+ (instancetype)shopUnitWithUnitName:(NSString *)aUnitName
                              unitID:(NSInteger)aUnitID
                            unitType:(RPGShopUnitType)aUnitType
                           unitCount:(NSInteger)aUnitCount
                           priceType:(RPGShopUnitPriceType)aPriceType
                          priceCount:(NSInteger)aPriceCount
                             skillID:(NSInteger)aSkillID;


@end
