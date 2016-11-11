//
//  RPGAlert.m
//  RPG Game
//
//  Created by Максим Шульга on 11/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAlert.h"
#import <UIKit/UIKit.h>

@implementation RPGAlert

#pragma mark - Show Alert

+ (void)showAlertViewControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                              completion:(void (^)())completionHandler
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleAlert];
  __block UIAlertController *weakAlert = alert;
  [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                            style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction *action)
  {
    [weakAlert dismissViewControllerAnimated:YES completion:nil];
    if (completionHandler != nil)
    {
      completionHandler();
    }
  }]];
  
  UIViewController *currentView = [UIApplication sharedApplication].keyWindow.rootViewController;
  while (currentView.presentedViewController) {
    currentView = currentView.presentedViewController;
  }
  [currentView presentViewController:alert animated:YES completion:nil];
}

@end
