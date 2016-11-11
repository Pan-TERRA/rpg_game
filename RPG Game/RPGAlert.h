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

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                completion:(void (^)())completionHandler;

@end
