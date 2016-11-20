//
//  RPGAlertController.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPGAlertController : NSObject

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                completion:(void (^ __nullable)())completionHandler;

@end

NS_ASSUME_NONNULL_END