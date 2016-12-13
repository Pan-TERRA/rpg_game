//
//  UIViewController+RPGChildViewController.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "UIViewController+RPGChildViewController.h"

@implementation UIViewController (RPGChildViewController)

- (void)addChildViewController:(UIViewController *)aChildViewController
                         frame:(CGRect)aFrame
{
  [self addChildViewController:aChildViewController];
  aChildViewController.view.frame = aFrame;
  [self.view addSubview:aChildViewController.view];
  [aChildViewController didMoveToParentViewController:self];
}

- (void)addChildViewController:(UIViewController *)aChildViewController
                          view:(UIView *)aView
{
  [self addChildViewController:aChildViewController];
  aChildViewController.view.frame = CGRectMake(0, 0, aView.frame.size.width, aView.frame.size.height);
  [aView addSubview:aChildViewController.view];
  [aChildViewController didMoveToParentViewController:self];
}

@end
