//
//  RPGTournamentRewardRankViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentRewardRankViewController.h"
  // API
#import "RPGBattleController+RPGTournamentPresentationController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGPlayer.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGTournamentRewardRankViewController ()

@property (assign, nonatomic, readwrite) RPGTournamentController *tournamentController;

@property (assign, nonatomic, readwrite) IBOutlet UILabel *rankLabel;
@property (assign, nonatomic, readwrite) IBOutlet UILabel *winCountLabel;

@end

@implementation RPGTournamentRewardRankViewController

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [super initWithNibName:kRPGTournamentRewardRankViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = aBattleController;
  }
  
  return self;
}

- (void)updateView
{
  RPGBattleController *battleController = self.battleController;
  NSInteger currentWinCount = battleController.battle.player.currentWinCount;
  NSInteger absoluteWinsForCurrentRank = battleController.absoluteWinsForCurrentRank;
  NSInteger absoluteWinsForNextRank = battleController.absoluteWinsForNextRank;
  
  NSInteger totalWinsToNextRank = absoluteWinsForNextRank - absoluteWinsForCurrentRank;
  NSInteger currentWinsAtRank = currentWinCount - absoluteWinsForCurrentRank;
  
  self.rankLabel.text = [@(battleController.currentPlayerRank) stringValue];
  self.winCountLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)currentWinsAtRank, (long)totalWinsToNextRank];
}

@end
