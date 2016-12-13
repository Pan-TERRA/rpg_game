//
//  RPGBattleTimerViewController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 12/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Controllers
@class RPGBattleController;

@interface RPGBattleTimerViewController : UIViewController

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
                            turnDuration:(NSInteger)aTurnDuration;

- (void)registerTimerObservationKeyPath:(NSString *)aKeyPath;
- (void)invalidateTimer;
- (void)updateTimerLabel:(NSTimer *)aTimer;
- (void)restartTimer;

@end
