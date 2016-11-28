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
#import "RPGBattleInitResponse.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"

@interface RPGArenaController ()

@property (nonatomic, retain, readwrite) NSArray<NSNumber *> *skillIDs;

@end

@implementation RPGArenaController

#pragma mark - Init

- (instancetype)initWithSkillIDs:(NSArray *)aSkillIDs
{
  self = [super init];
  
  if (self != nil)
  {
    _skillIDs = [aSkillIDs retain];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillIDs release];
  
  [super dealloc];
}

#pragma mark - Actions

- (RPGRequest *)createBattleInitRequest
{
  NSString *token = [NSUserDefaults standardUserDefaults].sessionToken;
  return [RPGArenaInitRequest requestWithSkillIDs:self.skillIDs token:token];
}

// TODO: maybe pass skillIDs not with RPGArenaController, but using NSUserDefaults (default
// behavior for RPGBattleController)
- (NSArray<NSNumber *> *)getPlayerSkillIDs
{
  return self.skillIDs;
}

@end
