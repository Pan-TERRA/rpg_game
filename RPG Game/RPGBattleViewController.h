//
//  RPGBattleViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RPGBattleControllerGenerator;
@class RPGBattleController;

@interface RPGBattleViewController : UIViewController

@property (nonatomic, retain, readonly) RPGBattleController *battleController;

- (instancetype)initWithBattleControllerGenerator:(nonnull RPGBattleControllerGenerator *)aBattleControllerGenerator;

@end

NS_ASSUME_NONNULL_END