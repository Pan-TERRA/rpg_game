//
//  UIViewController+RPGChildViewController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RPGChildViewController)

- (void)addChildViewController:(UIViewController *)aChildViewController
                         frame:(CGRect)aFrame;
- (void)addChildViewController:(UIViewController *)aChildViewController
                          view:(UIView *)aView;

@end
