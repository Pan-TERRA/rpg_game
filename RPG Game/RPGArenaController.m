//
//  RPGArenaController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaController.h"
#import "RPGArenaInitRequest.h"
#import "RPGSkill.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGBattleInitResponse.h"

@implementation RPGArenaController

- (RPGRequest *)createBattleInitRequest
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  NSArray *skillIDs = [self.skills valueForKeyPath:@"@unionOfObjects.skillID"];
  return [RPGArenaInitRequest requestWithSkillIDs:skillIDs token:token];
}

- (NSArray<RPGSkill *> *)getPlayerSkills
{
  return self.skills;
}

@end
