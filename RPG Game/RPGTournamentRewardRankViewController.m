//
//  RPGTournamentRewardRankViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentRewardRankViewController.h"
  // API
#import "RPGTournamentController+TournamentPresentationController.h"
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

- (instancetype)initWithTournamentController:(RPGTournamentController *)aTournamentController
{
  self = [super initWithNibName:kRPGCurrentWinCountBadgeViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _tournamentController = aTournamentController;
  }
  
  return self;
}

- (void)updateView
{
  RPGTournamentController *tournamentController = self.tournamentController;
  NSInteger currentWinCount = tournamentController.battle.player.currentWinCount;
  NSInteger absoluteWinsForCurrentRank = tournamentController.absoluteWinsForCurrentRank;
  NSInteger absoluteWinsForNextRank = tournamentController.absoluteWinsForNextRank;
  
  NSInteger totalWinsToNextRank = absoluteWinsForNextRank - absoluteWinsForCurrentRank;
  NSInteger currentWinsAtRank = currentWinCount - absoluteWinsForCurrentRank;
  
  self.rankLabel.text = [@(tournamentController.currentPlayerRank) stringValue];
  self.winCountLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)currentWinsAtRank, (long)totalWinsToNextRank];
}

@end
