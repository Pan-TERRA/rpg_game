//
//  RPGArenaFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaFactory.h"
  // Controllers
#import "RPGBattleController.h"
#import "RPGArenaControllerGenerator.h"
#import "RPGRewardViewController.h"
#import "RPGWaitingViewController.h"

NSString * const kRPGArenaFactoryBattleInitMessage = @"Wait for opponent...";

@interface RPGArenaFactory ()

@property (retain, nonatomic, readwrite) RPGBattleController *battleController;
@property (retain, nonatomic, readwrite) RPGRewardViewController *rewardViewController;
@property (retain, nonatomic, readwrite) RPGWaitingViewController *battleInitViewController;

@end

@implementation RPGArenaFactory

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    RPGArenaControllerGenerator *battleControllerGenerator = [[[RPGArenaControllerGenerator alloc] init] autorelease];
    _battleController = [[battleControllerGenerator battleController] retain];
    _rewardViewController = [[RPGRewardViewController alloc] initWithBattleController:_battleController];
    _battleInitViewController = [[RPGWaitingViewController alloc] initWithMessage:kRPGArenaFactoryBattleInitMessage];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleController release];
  [_rewardViewController release];
  [_battleInitViewController release];
  
  [super dealloc];
}

@end
