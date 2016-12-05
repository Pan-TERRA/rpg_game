//
//  RPGTournamentViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentViewController.h"
  // Controllers
#import "RPGCurrentWinCountBadgeViewController.h"
#import "RPGBattleController.h"
  // Entities
#import "RPGBattle.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"

@interface RPGTournamentViewController ()

@property (nonatomic, retain, readwrite) RPGCurrentWinCountBadgeViewController *badgeViewController;

@end

@implementation RPGTournamentViewController

#pragma mark - Init

- (instancetype)initWithBattleControllerGenerator:(RPGBattleControllerGenerator *)aBattleControllerGenerator
{
  self = [super initWithBattleControllerGenerator:aBattleControllerGenerator];
  
  if (self != nil)
  {
    _badgeViewController = [[RPGCurrentWinCountBadgeViewController alloc] init];
  }
  
  return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [self addChildViewController:self.badgeViewController view:self.currentWinCountBadgeViewContainer];
  
  [super viewDidLoad];
}

#pragma mark - RPGBattleViewController

- (void)processBattleInitCompletion
{
  self.badgeViewController.player = self.battleController.battle.player;
}

- (void)processModelChanges
{
  [self.badgeViewController updateView];
}

@end
