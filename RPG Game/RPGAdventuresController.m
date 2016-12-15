//
//  RPGAdventuresController.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresController.h"
  // API
#import "RPGWebsocketManager.h"
  // Entities
#import "RPGAdventuresInitRequest.h"
#import "RPGAdventuresInitResponse.h"
#import "RPGAdventuresConditionResponse.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGSkill.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGMessageTypes.h"
#import "RPGUserSessionKeys.h"
#import "RPGStatusCodes.h"

@implementation RPGAdventuresController

#pragma mark - Init

- (instancetype)initWithWebSocketManager:(RPGWebsocketManager *)aManager stageID:(NSInteger)aStageID
{
  self = [super initWithWebSocketManager:aManager];
  
  if (self != nil)
  {
    _stageID = aStageID;
  }
  
  return self;
}

#pragma mark - Creating Request

- (RPGRequest *)createBattleInitRequest
{
  return [RPGAdventuresInitRequest requestWithType:kRPGAdventuresInitMessageType stageID:self.stageID];
}

#pragma mark - Battle Init Response

- (void)processBattleInitResponse:(NSDictionary *)aResponse
{
  RPGAdventuresInitResponse *battleInitResponse = [[[RPGAdventuresInitResponse alloc]
                                                    initWithDictionaryRepresentation:aResponse] autorelease];
  
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
  else if (battleInitResponse.status != 0)
  {
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGBattleInitDidEndSetUpNotification
                                                        object:self
                                                      userInfo:@{
                                                                 kRPGBattleControllerUserInfoErrorCodeKey: @(battleInitResponse.status)
                                                                 }];
  }
}

#pragma mark - Battle Condition Response

- (void)processBattleConditionResponse:(NSDictionary *)aResponse
{
  RPGAdventuresConditionResponse *battleConditionResponse = [[[RPGAdventuresConditionResponse alloc]
                                                              initWithDictionaryRepresentation:aResponse] autorelease];
  
  if (battleConditionResponse != nil && battleConditionResponse.status == kRPGStatusCodeOK)
  {
    [self.battle updateWithBattleConditionResponse:battleConditionResponse];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRPGModelDidChangeNotification object:self];
  }
}

@end
