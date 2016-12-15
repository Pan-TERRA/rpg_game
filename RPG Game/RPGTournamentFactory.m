//
//  RPGTournamentFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentFactory.h"
  // Controllers
#import "RPGBattleController.h"
#import "RPGTournamentControllerGenerator.h"
#import "RPGTournamentRewardViewController.h"
#import "RPGWaitingViewController.h"

NSString * const kRPGTournamentFactoryBattleInitMessage = @"Wait for opponent...";

@interface RPGTournamentFactory ()

@property (retain, nonatomic, readwrite) RPGBattleController *battleController;
@property (retain, nonatomic, readwrite) RPGRewardViewController *rewardViewController;
@property (retain, nonatomic, readwrite) RPGWaitingViewController *battleInitViewController;

@end

@implementation RPGTournamentFactory

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    RPGTournamentControllerGenerator *battleControllerGenerator = [[[RPGTournamentControllerGenerator alloc] init] autorelease];
    _battleController = [[battleControllerGenerator battleController] retain];
    _rewardViewController = [[RPGTournamentRewardViewController alloc] initWithBattleController:_battleController];
    _battleInitViewController = [[RPGWaitingViewController alloc] initWithMessage:kRPGTournamentFactoryBattleInitMessage];
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
