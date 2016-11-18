//
//  RPGNetworkManager+Skills.h
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

@class RPGCharacterRequest;
@class RPGSkillsResponse;

@interface RPGNetworkManager (Skills)


/**
 *  Fetches skill identifiers by specific character ID.
 *
 *  @param aCharacterID  A character ID.
 *  @param callbackBlock Completion handler.
 */
- (void)fetchSkillsByCharacterID:(NSInteger)aCharacterID
               completionHandler:(void (^)(NSInteger status, NSArray *skills))callbackBlock;

/**
 *  Fetches skill info such as name, description, multiplier.
 *
 *  @param anID A skill ID.
 *  @param callbackBlock Completion handler.
 */
- (void)getSkillInfoByID:(NSInteger)anID
       completionHandler:(void (^)(NSInteger status, NSDictionary *skillInfo))callbackBlock;

- (void)selectSkillsWithRequest:(RPGCharacterRequest *)aRequest
              completionHandler:(void (^)(RPGSkillsResponse *))callbackBlock;

@end
