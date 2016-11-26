//
//  RPGBattleControllerGenerator.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleControllerGenerator.h"
  // Controllers
#import "RPGBattleController.h"

@implementation RPGBattleControllerGenerator

- (RPGBattleController *)battleController
{
  return [[[RPGBattleController alloc] init] autorelease];
}

@end
