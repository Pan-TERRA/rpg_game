  //
  //  RPGAlertController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 11/18/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGAlertController.h"
  // Controller
#import "RPGAlertViewController.h"
  // Misc
#import "UIWindow+RPGPresentController.h"

static NSString * const kRPGAlertControllerDefaultTitle = @"Error";
static NSString * const kRPGAlertControllerDefaultMessage = @"Error message";
static NSString * const kRPGAlertControllerDefaultActionTitle = @"OK";

@implementation RPGAlertController

+ (void)showAlertWithTitle:(NSString * __nullable)aTitle
                   message:(NSString * __nullable)aMessage
               actionTitle:(NSString * __nullable)anActionTitle
                completion:(void (^ __nullable)())completionHandler
{
  if (aTitle == nil)
  {
    aTitle = kRPGAlertControllerDefaultTitle;
  }
  
  if (aMessage == nil)
  {
    aMessage = kRPGAlertControllerDefaultMessage;
  }
  
  if (anActionTitle == nil)
  {
    anActionTitle = kRPGAlertControllerDefaultActionTitle;
  }
  
  RPGAlertViewController *alertViewController = [[RPGAlertViewController alloc] initWithTitle:aTitle
                                                                    description:aMessage
                                                                    actionTitle:anActionTitle
                                                              completionHandler:completionHandler];
 
  
  UIViewController *currentViewController = [[UIApplication sharedApplication].keyWindow visibleViewController];
  
  alertViewController.view.frame = currentViewController.view.frame;
  [alertViewController setModalPresentationStyle:UIModalPresentationCustom];
  [alertViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
  
  [currentViewController presentViewController:alertViewController animated:YES completion:nil];
}

@end
