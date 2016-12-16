//
//  RPGNetworkManager+Classes.h
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Entities
@class RPGClassesResponse;
@class RPGClassInfoResponse;

@interface RPGNetworkManager (Classes)

/**
 *  Fetches class identifiers.
 *
 *  @param aCallback A completion handler
 */
- (void)fetchClassesWithCompletionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                                    RPGClassesResponse *aResponse))aCallback;

/**
 *  Fetches class info such as name and description.
 *
 *  @param anID          A class ID.
 *  @param aCallback A completion handler.
 */
- (void)getClassInfoByID:(NSInteger)anID
       completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                   RPGClassInfoResponse *aResponse))aCallback;

@end
