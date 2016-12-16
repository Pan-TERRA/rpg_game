//
//  UIViewController + (RPGWrongTokenHandling).m
//  RPG Game
//
//  Created by Владислав Крут on 12/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "UIViewController+RPGWrongTokenHandling.h"
  // View
#import "RPGAlertController.h"

@implementation UIViewController (RPGWrongTokenHandling)

- (void)handleWrongTokenError
{
  [RPGAlertController showAlertWithTitle:nil
                                 message:@"Log in again, please"
                             actionTitle:nil
                              completion:^(void)
   {
     dispatch_async(dispatch_get_main_queue(), ^
      {
        UIViewController *root = [[UIApplication sharedApplication].delegate window].rootViewController;
        [root dismissViewControllerAnimated:YES completion:nil];
        
      });
   }];
}

@end
