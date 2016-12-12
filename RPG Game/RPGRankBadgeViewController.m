//
//  RPGRankBadgeViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRankBadgeViewController.h"
  // API
#import "RPGBattleController+RPGTournamentPresentationController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGRankBadgeViewController ()

@property (assign, nonatomic, readwrite) IBOutlet UILabel *rankLabel;

@property (assign, nonatomic, readwrite) RPGBattleController *battleController;

@end

@implementation RPGRankBadgeViewController

#pragma mark - Init

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [super initWithNibName:kRPGRankBadgeViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = aBattleController;
  }
  
  return self;
}

#pragma mark - Actions

- (void)updateView
{
  self.rankLabel.text = [@(self.battleController.currentPlayerRank) stringValue];
}

@end
