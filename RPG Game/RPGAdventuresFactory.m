//
//  RPGAdventuresFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresFactory.h"
  // Controllers
#import "RPGAdventuresControllerGenerator.h"
#import "RPGRewardViewController.h"
  // Misc
#import "RPGBattleFactoryPrivateProperties.h"

@implementation RPGAdventuresFactory

#pragma mark - Init

- (instancetype)initWithBattleplaceID:(NSInteger)aBattleplaceID
{
  self = [super init];
  
  if (self != nil)
  {
    if (aBattleplaceID >= 0)
    {
      RPGAdventuresControllerGenerator *battleControllerGenerator = [[RPGAdventuresControllerGenerator alloc] initWithStageID:aBattleplaceID];
      self.battleController = [battleControllerGenerator battleController];
      
      [battleControllerGenerator release];
      
      self.rewardViewController = [[[RPGRewardViewController alloc] initWithBattleController:self.battleController] autorelease];
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithBattleplaceID:-1];
}

@end
