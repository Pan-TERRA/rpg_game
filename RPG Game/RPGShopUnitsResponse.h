//
//  RPGShopUnitsResponse.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGShopUnitsResponse : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSInteger status;
@property (nonatomic, copy, readonly) NSArray<NSDictionary *> *shopUnits;

- (instancetype)initWithStatus:(NSInteger)aStatus
                     shopUnits:(NSArray<NSDictionary *> *)aShopUnits NS_DESIGNATED_INITIALIZER;
+ (instancetype)shopUnitResponseWithStatus:(NSInteger)aStatus
                                 shopUnits:(NSArray<NSDictionary *> *)aShopUnits;

@end
