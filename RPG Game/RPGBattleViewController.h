//
//  RPGBattleViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Misc
#import "RPGPresentingViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class RPGBattleFactory;
  // Controllers
@class RPGBattleController;

/**
 *  General battle view.
 *  Represents a battle between player and other entity (either player or bot).
 *  May be subclassed to add specific battle's behaviour (different kinds of battle may need
 *  different representations, e.g. adding some subviews).
 */
@interface RPGBattleViewController : UIViewController

@property (nonatomic, retain, readonly) RPGBattleController *battleController;
@property (nonatomic, assign, readwrite) id<RPGPresentingViewController> delegate;
  // Containers
@property (nonatomic, assign, readonly) IBOutlet UIView *currentWinCountBadgeViewContainer;

- (instancetype)initWithBattleFactory:(nonnull RPGBattleFactory *)aBattleFactory;

- (void)modelDidChange:(NSNotification *)aNotification NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
