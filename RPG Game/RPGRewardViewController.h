//
//  RPGRewardViewController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Controllers
@class RPGBattleController;
@class RPGRewardViewController;

@protocol RPGRewardModalDelegate <NSObject>

- (void)dismissRewardModal:(RPGRewardViewController *)aRewardModal;
- (void)restartBattle:(RPGRewardViewController *)aRewardModal;

@end

@interface RPGRewardViewController : UIViewController

@property (nonatomic, assign, readwrite) id<RPGRewardModalDelegate> delegate;

@property (nonatomic, assign, readonly) IBOutlet UIButton *restartButton;

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController;

- (void)updateView NS_REQUIRES_SUPER;

@end
