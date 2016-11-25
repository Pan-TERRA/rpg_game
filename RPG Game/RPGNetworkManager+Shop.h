//
//  RPGNetworkManager+Shop.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGStatusCodes.h"

@class RPGShopUnitsResponse;

@interface RPGNetworkManager (Shop)

- (void)fetchShopUnitsWithCompletionHandler:(void (^)(RPGStatusCode networkStatusCode,
                            RPGShopUnitsResponse *))callbackBlock;

- (void)buyShopUnitWithUnitID:(NSInteger)unitID
            completionHandler:(void (^)(NSInteger))callbackBlock;

@end
