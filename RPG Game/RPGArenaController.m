//
//  RPGArenaController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaController.h"
  // Entities
#import "RPGArenaInitRequest.h"
#import "RPGArenaInitResponse.h"
#import "RPGArenaConditionResponse.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGSkill.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"
#import "RPGStatusCodes.h"

@implementation RPGArenaController

#pragma mark - Creating Request

- (RPGRequest *)createBattleInitRequest
{
  NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  NSArray *skillIDs = standardUserDefaults.selectedArenaSkills;
  
  return [RPGArenaInitRequest requestWithSkillIDs:skillIDs];
}

#pragma mark - Battle Init Response

- (void)processBattleInitResponse:(NSDictionary *)aResponse
{
  RPGArenaInitResponse *battleInitResponse = [[[RPGArenaInitResponse alloc]
                                               initWithDictionaryRepresentation:aResponse]
                                              autorelease];
  
  if (battleInitResponse != nil && battleInitResponse.status == kRPGStatusCodeOK)
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

#pragma mark - Battle Condition Response

- (void)processBattleConditionResponse:(NSDictionary *)aResponse
{
  RPGArenaConditionResponse *battleConditionResponse = [[[RPGArenaConditionResponse alloc]
                                                         initWithDictionaryRepresentation:aResponse] autorelease];
  
  if (battleConditionResponse != nil && battleConditionResponse.status == kRPGStatusCodeOK)
  {
    [self.battle updateWithBattleConditionResponse:battleConditionResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification object:self];
  }
}

@end
