//
//  RPGAlert.h
//  RPG Game
//
//  Created by Максим Шульга on 11/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface RPGAlert : NSObject

+ (void)showAlertViewControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          viewController:(UIViewController *)viewController
                              completion:(void (^)())completionHandler;

@end
