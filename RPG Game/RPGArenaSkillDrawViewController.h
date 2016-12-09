//
//  RPGArenaSkillDrawViewController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/20/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Typically, the view controller, which has presented this view controller, should conform to such
 *  protocol for implementing complicated transitions
 */
@protocol RPGPresentingViewController <NSObject>

- (void)dismissCurrentAndPresentViewController:(UIViewController *)aViewController;

@end

@interface RPGArenaSkillDrawViewController : UIViewController

@property (nonatomic, assign, readwrite) id<RPGPresentingViewController> delegate;

@end
