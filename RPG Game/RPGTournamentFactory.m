//
//  RPGTournamentFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTournamentFactory.h"
#import "RPGTournamentController.h"
#import "RPGTournamentControllerGenerator.h"
#import "RPGTournamentRewardViewController.h"
#import "RPGRewardViewController.h"
#import "RPGBattleFactoryPrivateProperties.h"

@implementation RPGTournamentFactory

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    RPGTournamentControllerGenerator *battleControllerGenerator = [[[RPGTournamentControllerGenerator alloc] init] autorelease];
    self.battleController = [battleControllerGenerator battleController];
    self.rewardViewController = [[RPGTournamentRewardViewController alloc] initWithBattleController:self.battleController];
  }
  
  return self;
}

@end
