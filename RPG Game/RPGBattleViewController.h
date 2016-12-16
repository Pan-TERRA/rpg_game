//
//  RPGBattleViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // API
#import "RPGBattleFactoryProtocol.h"
  // Misc
#import "RPGPresentingViewControllerProtocol.h"
@class RPGBattleFactoryProtocol;

NS_ASSUME_NONNULL_BEGIN

  // Controllers
@class RPGBattleController;

@protocol RPGBattleViewControllerDelegate <NSObject>

- (void)battleViewControllerDidEndBattle;

@end

/**
 *  General battle view.
 *  Represents a battle between player and other entity (either player or bot).
 *  May be subclassed to add specific battle's behaviour (different kinds of battle may need
 *  different representations, e.g. adding some subviews).
 */
@interface RPGBattleViewController : UIViewController

@property (nonatomic, retain, readonly) RPGBattleController *battleController;
@property (nonatomic, assign, readwrite) id<RPGPresentingViewController> delegate;
@property (nonatomic, assign, readwrite) id<RPGBattleViewControllerDelegate> battleViewControllerDelegate;
  // Containers
@property (nonatomic, assign, readonly) IBOutlet UIView *currentWinCountBadgeViewContainer;

- (instancetype)initWithBattleFactory:(nonnull id<RPGBattleFactoryProtocol>)aBattleFactory;

- (void)modelDidChange:(NSNotification *)aNotification NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
