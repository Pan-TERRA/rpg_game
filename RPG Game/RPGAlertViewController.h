//
//  RPGAlert.h
//  RPG Game
//
//  Created by Максим Шульга on 11/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPGAlertViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)aTitle
                  description:(NSString *)aDescription
            completionHandler:(void(^ __nullable)(void))aCompletionHandler;


@end

NS_ASSUME_NONNULL_END
