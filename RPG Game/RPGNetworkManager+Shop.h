//
//  RPGNetworkManager+Shop.h
//  RPG Game
//
//  Created by Владислав Крут on 11/23/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Constants
#import "RPGStatusCodes.h"
  // Entities
@class RPGShopUnitsResponse;
@class RPGShopUnitRequest;

@interface RPGNetworkManager (Shop)

- (void)fetchShopUnitsWithCompletionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                                      RPGShopUnitsResponse *aShopUnitResponse))aCallback;

- (void)buyShopUnitWithRequest:(RPGShopUnitRequest *)aRequest
            completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallback;

@end
