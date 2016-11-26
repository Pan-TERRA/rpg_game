//
//  RPGArenaControllerGenerator.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaControllerGenerator.h"
  // Controllers
#import "RPGArenaController.h"

static NSString * const kRPGArenaControllerBattleInitMessageType = @"ARENA_INIT";
// TODO: Change To ArenaCondition
static NSString * const kRPGArenaControllerBattleConditionMessageType = @"BATTLE_CONDITION";

@interface RPGArenaControllerGenerator ()

@property (retain, nonatomic, readwrite) NSArray *skillsID;

@end

@implementation RPGArenaControllerGenerator

#pragma mark - Init

- (instancetype)initWithSkillsID:(NSArray *)aSkillsID
{
  self = [super init];
  
  if (self != nil)
  {
    _skillsID = [aSkillsID retain];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsID release];
  
  [super dealloc];
}

- (RPGBattleController *)battleController
{
  RPGArenaController *controller = [[[RPGArenaController alloc] init] autorelease];
  [controller registerWebSocketMessageTypeForBattleInitResponse:kRPGArenaControllerBattleInitMessageType];
  [controller registerWebSocketMessageTypeForBattleConditionResponse:kRPGArenaControllerBattleConditionMessageType];
  controller.skillsID = self.skillsID;
  
  return controller;
}

@end
