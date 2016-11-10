//
//  RPGSkillBarViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 11/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGBattleManager;

@interface RPGSkillBarViewController : UIViewController

@property (nonatomic, assign, readonly) RPGBattleManager *battleManager;

- (instancetype)initWithBattleManager:(RPGBattleManager *)aBattleManager;

@end
