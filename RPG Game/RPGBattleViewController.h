//
//  RPGBattleViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGBattleManager.h"

@interface RPGBattleViewController : UIViewController

@property(nonatomic, retain, readonly) RPGBattleManager *battleManager;

@end
