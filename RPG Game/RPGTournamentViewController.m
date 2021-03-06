//
//  RPGTournamentViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/4/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentViewController.h"
  // API
#import "RPGBattleFactoryProtocol.h"
  // Controllers
#import "RPGRankBadgeViewController.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"

@interface RPGTournamentViewController ()

@property (nonatomic, retain, readwrite) RPGRankBadgeViewController *badgeViewController;

@end

@implementation RPGTournamentViewController

#pragma mark - Init

- (instancetype)initWithBattleFactory:(id<RPGBattleFactoryProtocol>)aBattleFactory
{
  self = [super initWithBattleFactory:aBattleFactory];
  
  if (self != nil)
  {
    _badgeViewController = [[RPGRankBadgeViewController alloc] initWithBattleController:aBattleFactory.battleController];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_badgeViewController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self addChildViewController:self.badgeViewController view:self.currentWinCountBadgeViewContainer];
}

#pragma mark - RPGBattleViewController

- (void)modelDidChange:(NSNotification *)aNotification
{
  [super modelDidChange:aNotification];
  
  [self.badgeViewController updateView];
}

@end
