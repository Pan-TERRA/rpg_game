//
//  RPGTournamentRewardRankViewController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGBattleController;

/**
 *  Created and used by RPGTournamentRewardViewController
 */
@interface RPGTournamentRewardRankViewController : UIViewController

@property (assign, nonatomic, readonly) RPGBattleController *battleController;

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController;

- (void)updateView;

@end
