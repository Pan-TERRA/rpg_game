//
//  RPGBattlePresentingViewControllerProtocol.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/29/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

/**
 *  Typically, the view controller, which has presented this view controller, should conform to such
 *  protocol for implementing complicated transitions
 */
@protocol RPGBattlePresentingViewController <NSObject>

- (void)dismissCurrentAndPresentViewController:(UIViewController *)aViewController;
- (void)restartBattle:(UIViewController *)aViewController;

@end
