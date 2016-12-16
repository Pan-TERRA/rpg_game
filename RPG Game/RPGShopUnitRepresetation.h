//
//  RPGShopUnitRepresetation.h
//  RPG Game
//
//  Created by Владислав Крут on 12/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGShopUnit.h"

@interface RPGShopUnitRepresetation : NSObject

@property (nonatomic, assign, readonly) NSInteger shopUnitID;
@property (nonatomic, copy, readonly) NSString *shopUnitName;
@property (nonatomic, assign, readonly) RPGShopUnitType unitType;
@property (nonatomic, assign, readonly) NSInteger unitCount;
@property (nonatomic, assign, readonly) RPGShopUnitPriceType priceType;
@property (nonatomic, assign, readonly) NSInteger priceCount;
@property (nonatomic, assign, readonly) NSInteger skillID;

@property (nonatomic, copy, readonly) NSString *shopUnitDescription;
@property (nonatomic, copy, readonly) NSString *imageName;

- (instancetype)initWithShopUnit:(RPGShopUnit *)aShopUnit NS_DESIGNATED_INITIALIZER;
+ (instancetype)shopUnitRepresetationWithShopUnit:(RPGShopUnit *)aShopUnit;

@end
