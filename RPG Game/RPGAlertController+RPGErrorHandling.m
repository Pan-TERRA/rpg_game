//
//  RPGAlertController+RPGErrorHandling.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAlertController+RPGErrorHandling.h"

@implementation RPGAlertController (RPGErrorHandling)

#pragma mark - Helper Method

+ (void)showErrorWithStatusCode:(RPGStatusCode)aStatusCode
              completionHandler:(void (^ _Nullable)())aCompletionHandler
{
  [RPGAlertController showAlertWithTitle:RPGStatusCodeTitle[aStatusCode]
                                 message:RPGStatusCodeDescription[aStatusCode]
                             actionTitle:RPGStatusCodeActionTitle[aStatusCode]
                              completion:aCompletionHandler];
}

#pragma mark - Default

+ (void)handleDefaultError
{
  [self showErrorWithStatusCode:kRPGStatusCodeDefaultError
              completionHandler:nil];
}

@end
