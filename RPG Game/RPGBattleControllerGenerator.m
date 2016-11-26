//
//  RPGBattleControllerFactory.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleControllerFactory.h"
  // Controllers
#import "RPGBattleController.h"

@implementation RPGBattleControllerFactory

#pragma mark - Init

#pragma mark - Dealloc

#pragma mark - Factory

- (RPGBattleController *)battleController
{
  return [[[RPGBattleController alloc] init] autorelease];
}

@end
