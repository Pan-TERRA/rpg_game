//
//  RPGShopBuyUnitRequest.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

@interface RPGShopUnitRequest : NSObject <RPGSerializable>

@property (assign, nonatomic, readwrite) NSInteger shopUnitID;

- (instancetype)initWithShopUnitID:(NSInteger)aShopUnitID NS_DESIGNATED_INITIALIZER;
+ (instancetype)shopUnitRequestWithShopUnitID:(NSInteger)aShopUnitID;

@end
