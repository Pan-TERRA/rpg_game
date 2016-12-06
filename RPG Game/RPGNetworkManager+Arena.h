//
//  RPGNetworkManager+Arena.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
  // Constants
#import "RPGStatusCodes.h"
  // Entities
@class RPGArenaSkillsResponse;

@interface RPGNetworkManager (Arena)

- (void)fetchSkillsWithCompletionHandler:(void (^)(RPGStatusCode, RPGArenaSkillsResponse *))aCallback;
- (void)arenaPayWithCompletionHandler:(void (^)(RPGStatusCode))aCallback;

@end
