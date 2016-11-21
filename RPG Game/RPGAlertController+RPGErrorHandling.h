//
//  RPGAlertController+RPGErrorHandling.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAlertController.h"
  // Constants
#import "RPGStatusCodes.h"

@interface RPGAlertController (RPGErrorHandling)

+ (void)showErrorWithStatusCode:(RPGStatusCode)aStatusCode;

+ (void)handleDefaultError;

@end
