//
//  RPGBattleViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGPresentingViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class RPGBattleControllerGenerator;
@class RPGBattleController;

@interface RPGBattleViewController : UIViewController

@property (nonatomic, retain, readonly) RPGBattleController *battleController;
@property (nonatomic, assign, readwrite) id<RPGPresentingViewController> delegate;
  // Containers
@property (nonatomic, assign, readonly) IBOutlet UIView *currentWinCountBadgeViewContainer;

- (instancetype)initWithBattleControllerGenerator:(nonnull RPGBattleControllerGenerator *)aBattleControllerGenerator;

  // template method
- (void)processModelChanges;

@end

NS_ASSUME_NONNULL_END
