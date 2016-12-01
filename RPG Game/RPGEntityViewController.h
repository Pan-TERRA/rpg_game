  //
  //  RPGEntityViewController.h
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/1/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import <UIKit/UIKit.h>
  // Controllers
@class RPGBattleController;
  // Views
#import "RPGProgressBarView.h"

@interface RPGEntityViewController : UIViewController

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
                                   align:(RPGProgressBarAlign)anAlignFlag;

- (void)registerObservationEntityByKeyPath:(NSString *)aKeyPath;

- (void)updateViewWithKeyPath:(NSString *)aKeyPath;


@end
