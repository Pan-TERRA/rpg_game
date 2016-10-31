//
//  RPGNetworkManager+Skills.h
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

@class RPGSkillsRequest;

@interface RPGNetworkManager (Skills)

- (void)fetchSkillsByCharacterID:(NSInteger)characterID completionHandler:(void (^)(NSInteger status, NSArray *skills))callbackBlock;
- (void)getSkillInfoByID:(NSInteger)ID completionHandler:(void (^)(NSInteger status, NSDictionary *skillInfo))callbackBlock;

@end
