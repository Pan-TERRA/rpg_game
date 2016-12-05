//
//  RPGSkillsEffectsViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGBattleController;

@interface RPGSkillsEffectsViewController : UIViewController

@property (nonatomic, retain, readonly) RPGBattleController *battleController;

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController;

@end
