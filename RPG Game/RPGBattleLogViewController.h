//
//  RPGBattleLogViewController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGBattleManager;

@interface RPGBattleLogViewController : UIViewController

@property (assign, nonatomic, readonly) RPGBattleManager *battleManager;

- (instancetype)initWithBattleManager:(RPGBattleManager *)aBattleManager;

@end
