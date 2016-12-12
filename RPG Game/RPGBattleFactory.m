//
//  RPGBattleFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleFactory.h"
#import "RPGBattleFactoryPrivateProperties.h"

@implementation RPGBattleFactory

#pragma mark - Dealloc

- (void)dealloc
{
  [_rewardViewController release];
  [_battleController release];

  [super dealloc];
}

@end
