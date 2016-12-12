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
#import "RPGBattle.h"
#import "RPGSkill.h"
#import "RPGPlayer.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"
#import "RPGUserSessionKeys.h"

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
  
  if (battleInitResponse != nil && battleInitResponse.status == 0)
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

@end
