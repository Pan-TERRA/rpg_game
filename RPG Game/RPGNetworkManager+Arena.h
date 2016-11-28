//
//  RPGNetworkManager+Arena.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGStatusCodes.h"

@class RPGArenaSkillsResponse;

@interface RPGNetworkManager (Arena)

- (void)fetchSkillsWithCompletionHandler:(void (^)(RPGStatusCode, RPGArenaSkillsResponse *))callbackBlock;
- (void)arenaPayWithCompletionHandler:(void (^)(RPGStatusCode))callbackBlock;

@end
