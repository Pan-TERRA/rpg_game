//
//  RPGAdventuresFactory.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresFactory.h"
  // Controllers
#import "RPGBattleController.h"
#import "RPGAdventuresControllerGenerator.h"
#import "RPGRewardViewController.h"
#import "RPGWaitingViewController.h"

NSString * const kRPGAdventuresFactoryBattleInitMessage = @"Battle init";

@interface RPGAdventuresFactory ()

@property (retain, nonatomic, readwrite) RPGBattleController *battleController;
@property (retain, nonatomic, readwrite) RPGRewardViewController *rewardViewController;
@property (retain, nonatomic, readwrite) RPGWaitingViewController *battleInitViewController;

@end

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
      _battleController = [[battleControllerGenerator battleController] retain];
      
      [battleControllerGenerator release];
      
      _rewardViewController = [[RPGRewardViewController alloc] initWithBattleController:_battleController];
      _battleInitViewController = [[RPGWaitingViewController alloc] initWithMessage:kRPGAdventuresFactoryBattleInitMessage];
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

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleController release];
  [_rewardViewController release];
  [_battleInitViewController release];
  
  [super dealloc];
}

@end
