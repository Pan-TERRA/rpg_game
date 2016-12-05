//
//  RPGCurrentWinCountBadgeViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCurrentWinCountBadgeViewController.h"
  // Entities
#import "RPGPlayer.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGCurrentWinCountBadgeViewController ()

@property (assign, nonatomic, readwrite) IBOutlet UILabel *currentWinCountLabel;

@end

@implementation RPGCurrentWinCountBadgeViewController

- (instancetype)init
{
  return [super initWithNibName:kRPGCurrentWinCountBadgeViewControllerNIBName bundle:nil];
}

- (void)updateView
{
  self.currentWinCountLabel.text = [@(self.player.currentWinCount) stringValue];
}

@end
