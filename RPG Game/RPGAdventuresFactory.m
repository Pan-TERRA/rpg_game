//
//  RPGAdventuresFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresFactory.h"
#import "RPGAdventuresControllerGenerator.h"
#import "RPGRewardViewController.h"
#import "RPGBattleFactoryPrivateProperties.h"

@implementation RPGAdventuresFactory

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    RPGAdventuresControllerGenerator *battleControllerGenerator = [[[RPGAdventuresControllerGenerator alloc] init] autorelease];
    self.battleController = [battleControllerGenerator battleController];
    self.rewardViewController = [[[RPGRewardViewController alloc] initWithBattleController:self.battleController] autorelease];
  }
  
  return self;
}

@end
