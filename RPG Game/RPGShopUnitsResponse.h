//
//  RPGShopUnitsResponse.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGShopUnitsResponse : NSObject <RPGSerializable>

@property (assign, nonatomic, readwrite) NSInteger status;
@property (copy, nonatomic, readwrite) NSArray *shopUnits;

- (instancetype)initWithStatus:(NSInteger)aStatus shopUnits:(NSArray *)aShopUnits NS_DESIGNATED_INITIALIZER;

@end
