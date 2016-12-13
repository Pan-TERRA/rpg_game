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
#import "RPGSkill.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGAdventuresInitResponse.h"
  // Misc
#import "RPGSerializable.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"

@implementation RPGArenaController

#pragma mark - Creating Request

- (RPGRequest *)createBattleInitRequest
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSArray *skillIDs = standardUserDefaults.selectedArenaSkills;
  
  return [RPGArenaInitRequest requestWithSkillIDs:skillIDs];
}

#pragma mark Process Manager Response

#pragma mark - Battle Init Response

- (void)processBattleInitResponse:(NSDictionary *)aResponse
{
  RPGAdventuresInitResponse *battleInitResponse = [[[RPGAdventuresInitResponse alloc]
                                                    initWithDictionaryRepresentation:aResponse]
                                                   autorelease];
  
  if (battleInitResponse != nil && battleInitResponse.status == 0)
  {
    self.battle = [RPGBattle battleWithBattleInitResponse:battleInitResponse];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *skillIDs = standardUserDefaults.selectedArenaSkills;
    
    NSMutableArray *skills = [NSMutableArray array];
    for (NSNumber *skillID in skillIDs)
    {
      RPGSkill *skill = [[RPGSkill alloc] initWithSkillID:[skillID integerValue]];
      [skills addObject:skill];
      [skill release];
    }
    self.battle.player.skills = skills;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleInitDidEndSetUpNotification
                                                        object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification
                                                        object:self];
  }
}

#pragma mark Battle Condition Response

#pragma mark - Actions

@end
