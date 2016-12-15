//
//  RPGTournamentController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentController.h"
  // Entities
#import "RPGRequest.h"
#import "RPGTournamentInitResponse.h"
#import "RPGTournamentConditionResponse.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGSkill.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"
#import "RPGUserSessionKeys.h"
#import "RPGStatusCodes.h"

@implementation RPGTournamentController

#pragma mark - Creating request

- (RPGRequest *)createBattleInitRequest
{
  return [RPGRequest requestWithType:kRPGTournamentInitMessageType];
}

#pragma mark - Battle Init Response

- (void)processBattleInitResponse:(NSDictionary *)aResponse
{
  RPGTournamentInitResponse *battleInitResponse = [[[RPGTournamentInitResponse alloc]
                                                   initWithDictionaryRepresentation:aResponse]
                                                  autorelease];
  
  if (battleInitResponse != nil && battleInitResponse.status == kRPGStatusCodeOK)
  {
    self.battle = [RPGBattle battleWithBattleInitResponse:battleInitResponse];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *skillIDs = standardUserDefaults.sessionCharacters.firstObject[kRPGUserSessionKeyCharacterSkills];
    
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
  RPGTournamentConditionResponse *battleConditionResponse = [[[RPGTournamentConditionResponse alloc]
                                                              initWithDictionaryRepresentation:aResponse] autorelease];
  
  if (battleConditionResponse != nil && battleConditionResponse.status == kRPGStatusCodeOK)
  {
    [self.battle updateWithBattleConditionResponse:battleConditionResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification object:self];
  }
}

@end
