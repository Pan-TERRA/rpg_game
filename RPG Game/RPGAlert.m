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

+ (void)showAlertViewControllerWithMessage:(NSString *)message viewController:(UIViewController *)viewController
{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                            style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction *action)
                    {
                      [alert dismissViewControllerAnimated:YES completion:nil];
                    }]];
  
  [viewController presentViewController:alert animated:YES completion:nil];
}

@end
