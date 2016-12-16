//
//  UIWindow+RPGPresentController.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "UIWindow+RPGPresentController.h"

@implementation UIWindow (RPGPresentController)

- (UIViewController *)visibleViewController
{
  UIViewController *rootViewController = self.rootViewController;
  
  return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc
{
  if ([vc isKindOfClass:[UINavigationController class]])
  {
    return [UIWindow getVisibleViewControllerFrom:((UINavigationController *)vc).visibleViewController];
  }
  else if ([vc isKindOfClass:[UITabBarController class]])
  {
    return [UIWindow getVisibleViewControllerFrom:((UITabBarController *)vc).selectedViewController];
  }
  else
  {
    if (vc.presentedViewController)
    {
      return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
    }
    else
    {
      return vc;
    }
  }
}

@end
