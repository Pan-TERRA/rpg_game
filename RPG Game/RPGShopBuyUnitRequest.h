//
//  RPGShopBuyUnitRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGShopBuyUnitRequest : NSObject <RPGSerializable>

@property (assign, nonatomic, readwrite) NSInteger shopUnitID;

- (instancetype)initWithShopUnitID:(NSInteger)aShopUnitID NS_DESIGNATED_INITIALIZER;
+ (instancetype)shopBuyUnitRequestWithShopUnitID:(NSInteger)aShopUnitID;

@end
