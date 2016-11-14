//
//  RPGBattleLogViewController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGBattleController;

@interface RPGBattleLogViewController : UIViewController

@property (retain, nonatomic, readonly) RPGBattleController *battleController;

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController;

@end
