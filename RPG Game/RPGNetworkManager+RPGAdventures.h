//
//  RPGNetworkManager+RPGAdventures.h
//  RPG Game
//
//  Created by Степан Супинский on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Entities
@class RPGAvailableLocationsResponse;
@class RPGLocationInfoResponse;


@interface RPGNetworkManager (RPGAdventures)

- (void)fetchAvailableLocationsWithCompletionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                                               RPGAvailableLocationsResponse *aResponse))aCallback;
- (void)getLocationInfoWithLocationID:(NSInteger)aLocationID
                    completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                                RPGLocationInfoResponse *aResponse))aCallback;

@end
