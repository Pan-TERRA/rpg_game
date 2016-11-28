//
//  RPGArenaController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaController.h"
  // API
#import "RPGWebsocketManager.h"
  // Entities
#import "RPGArenaInitRequest.h"
  // Misc
#import "RPGSerializable.h"
  // Constants
#import "RPGMessageTypes.h"

@interface RPGArenaController ()

@end

@implementation RPGArenaController

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsID release];
  
  [super dealloc];
}

#pragma mark - Creating Request

- (RPGRequest *)createBattleInitRequest
{
  return [RPGArenaInitRequest requestWithSkillIDs:self.skillsID];
}

#pragma mark Process Manager Response

#pragma mark Battle Init Response

#pragma mark Battle Condition Response

#pragma mark - Actions

- (void)sendBattleInitRequest
{
  id request = [self createBattleInitRequest];
  
  if (request != nil)
  {
    [self.webSocketManager sendWebsocketManagerMessageWithObject:request];
  }
  else
  {
    NSLog(@"Request is nil");
  }
}

#pragma mark - Misc

#pragma mark - Helper Methods

// TODO: maybe pass skillIDs not with RPGArenaController, but using NSUserDefaults (default
// behavior for RPGBattleController)
- (NSArray<NSNumber *> *)getPlayerSkillIDs
{
  return self.skillsID;
}

@end
