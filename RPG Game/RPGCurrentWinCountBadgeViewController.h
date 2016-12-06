//
//  RPGCurrentWinCountBadgeViewController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGBattleController;

@interface RPGCurrentWinCountBadgeViewController : UIViewController

@property (assign, nonatomic, readonly) RPGBattleController *battleController;

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController;

- (void)updateView;

@end
