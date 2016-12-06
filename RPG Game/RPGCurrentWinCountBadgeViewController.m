//
//  RPGCurrentWinCountBadgeViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCurrentWinCountBadgeViewController.h"
  // API
#import "RPGBattleController+RPGBattlePresentationController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGCurrentWinCountBadgeViewController ()

@property (assign, nonatomic, readwrite) IBOutlet UILabel *winCountLabel;

@property (assign, nonatomic, readwrite) RPGBattleController *battleController;

@end

@implementation RPGCurrentWinCountBadgeViewController

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [super initWithNibName:kRPGCurrentWinCountBadgeViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = aBattleController;
  }
  
  return self;
}

- (void)updateView
{
  RPGBattleController *battleController = self.battleController;
  NSInteger currentWinCount = battleController.playerCurrentWinCount;
  NSInteger absoluteWinsForCurrentRank = battleController.absoluteWinsForCurrentRank;
  NSInteger absoluteWinsForNextRank = battleController.absoluteWinsForNextRank;
  
  NSInteger totalWinsToNextRank = absoluteWinsForNextRank - absoluteWinsForCurrentRank;
  NSInteger currentWinsAtRank = currentWinCount - absoluteWinsForCurrentRank;
  
  self.winCountLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)currentWinsAtRank, (long)totalWinsToNextRank];
}

@end
