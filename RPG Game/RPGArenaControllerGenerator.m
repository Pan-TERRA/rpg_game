//
//  RPGArenaControllerGenerator.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaControllerGenerator.h"
  // API
#import "RPGWebsocketManager.h"
  // Controllers
#import "RPGArenaController.h"
  // Constants
#import "RPGMessageTypes.h"

static NSString * const kRPGWebsocketManagerAPIArenaBattle = @"ws://10.55.33.15:8888/arena_battle";

@interface RPGArenaControllerGenerator ()

@property (nonatomic, retain, readwrite) NSArray<NSNumber *> *skillsID;

@end

@implementation RPGArenaControllerGenerator

#pragma mark - Init

- (instancetype)initWithSkillsID:(NSArray<NSNumber *> *)aSkillsID
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
  RPGWebsocketManager *manager = [[RPGWebsocketManager alloc] initWithURL:[NSURL URLWithString:kRPGWebsocketManagerAPIArenaBattle]];
  RPGArenaController *controller = [[[RPGArenaController alloc] initWithWebSocketManager:manager] autorelease];
  manager.battleController = controller;
  [manager release];
  
  [controller registerWebSocketMessageTypeForBattleInitResponse:kRPGArenaInitMessageType];
  [controller registerWebSocketMessageTypeForBattleConditionResponse:kRPGArenaConditionMessageType];
  controller.skillsID = self.skillsID;
  
  return controller;
}

@end
