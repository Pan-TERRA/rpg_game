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
{
	 [RPGAlertController showAlertWithTitle:RPGStatusCodeTitle[aStatusCode]
                                  message:RPGStatusCodeDescription[aStatusCode]
                               completion:nil];
}

#pragma mark - Default

+ (void)handleDefaultError
{
  [self showErrorWithStatusCode:kRPGStatusCodeDefaultError];
}




@end
