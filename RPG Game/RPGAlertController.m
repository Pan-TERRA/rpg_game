  //
  //  RPGAlert.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 11/18/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGAlert.h"
  // Controller
#import "RPGAlertViewController.h"
  // Misc
#import "UIWindow+RPGPresentController.h"

@implementation RPGAlert

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                completion:(void (^ __nullable)())completionHandler
{
  RPGAlertViewController *alertViewController = [[RPGAlertViewController alloc] initWithTitle:title
                                                                    description:message
                                                                    actionTitle:@"OK"
                                                              completionHandler:completionHandler];
 
  
  UIViewController *currentViewController = [[UIApplication sharedApplication].keyWindow visibleViewController];
  alertViewController.view.frame = currentViewController.view.frame;
  [alertViewController setModalPresentationStyle:UIModalPresentationCustom];
  [alertViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
  [currentViewController presentViewController:alertViewController animated:YES completion:nil];
}

@end
