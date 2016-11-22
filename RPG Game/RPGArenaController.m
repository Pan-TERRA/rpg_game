//
//  RPGArenaController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaController.h"
#import "RPGArenaInitRequest.h"
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGBattleInitResponse.h"

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

- (NSArray<NSNumber *> *)getPlayerSkillIDs
{
  return self.skillIDs;
}

@end
