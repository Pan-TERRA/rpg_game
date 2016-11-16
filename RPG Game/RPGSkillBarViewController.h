//
//  RPGSkillBarViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 11/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGBattleController;

@interface RPGSkillBarViewController : UIViewController

@property (nonatomic, assign, readonly) RPGBattleController *battleController;

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController;
- (void)battleInitDidEndSetUp:(NSNotification *)aNotification;
- (void)setButtonsEnable:(BOOL)isEnabled;
@end
