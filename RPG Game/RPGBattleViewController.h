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

@class RPGBattleFactory;
@class RPGBattleController;
@class RPGRewardViewController;

@interface RPGBattleViewController : UIViewController

@property (nonatomic, retain, readonly) RPGBattleController *battleController;
@property (nonatomic, assign, readwrite) id<RPGPresentingViewController> delegate;
  // Containers
@property (nonatomic, assign, readonly) IBOutlet UIView *currentWinCountBadgeViewContainer;

- (instancetype)initWithBattleFactory:(nonnull RPGBattleFactory *)aBattleFactory;

- (void)modelDidChange:(NSNotification *)aNotification NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
