//
//  RPGArenaFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaFactory.h"
#import "RPGArenaControllerGenerator.h"
#import "RPGRewardViewController.h"
#import "RPGBattleFactoryPrivateProperties.h"

@implementation RPGArenaFactory

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    RPGArenaControllerGenerator *battleControllerGenerator = [[[RPGArenaControllerGenerator alloc] init] autorelease];
    self.battleController = [battleControllerGenerator battleController];
    self.rewardViewController = [[[RPGRewardViewController alloc] initWithBattleController:self.battleController] autorelease];
  }
  
  return self;
}

@end
