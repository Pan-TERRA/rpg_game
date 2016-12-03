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
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"

@interface RPGArenaController ()

@end

@implementation RPGArenaController

#pragma mark - Creating Request

- (RPGRequest *)createBattleInitRequest
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSArray *skillIDs = standardUserDefaults.selectedArenaSkills;
  
  return [RPGArenaInitRequest requestWithSkillIDs:skillIDs];
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

@end
