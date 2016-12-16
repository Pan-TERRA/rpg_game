//
//  RPGNetworkManager+Skills.h
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Entities
@class RPGSkillsSelectRequest;
@class RPGSkillInfoResponse;

@interface RPGNetworkManager (Skills)

/**
 *  Fetches skill info such as name, description, multiplier.
 *
 *  @param anID A skill ID.
 *  @param callbackBlock Completion handler.
 */
- (void)getSkillInfoByID:(NSInteger)anID
       completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode,
                                   RPGSkillInfoResponse *aResponse))aCallbackBlock;

- (void)selectSkillsWithRequest:(RPGSkillsSelectRequest *)aRequest
              completionHandler:(void (^)(RPGStatusCode aNetworkStatusCode))aCallbackBlock;

@end
