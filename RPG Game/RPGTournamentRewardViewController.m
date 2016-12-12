//
//  RPGTournamentRewardViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentRewardViewController.h"
  // Controllers
#import "RPGTournamentController.h"
#import "RPGTournamentRewardRankViewController.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"

@interface RPGTournamentRewardViewController ()

@property (nonatomic, retain, readwrite) RPGTournamentRewardRankViewController *rankViewController;

@end

@implementation RPGTournamentRewardViewController

#pragma mark - Init

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [super initWithBattleController:aBattleController];
  
  if (self != nil)
  {
    _rankViewController = [[RPGTournamentRewardRankViewController alloc] initWithBattleController:aBattleController];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_rankViewController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self addChildViewController:self.rankViewController view:self.rankContainer];
}

#pragma mark - RPGRewardViewController

- (void)updateView
{
  [super updateView];
  
  [self.rankViewController updateView];
}

@end
