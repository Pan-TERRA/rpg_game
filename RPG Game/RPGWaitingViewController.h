//
//  RPGWaitingViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPGWaitingViewController : UIViewController

@property (nonatomic, copy, readwrite) NSString *message;

- (instancetype)initWithMessage:(NSString *)aMessage completion:(void (^ __nullable)())completionHandler;

@end

NS_ASSUME_NONNULL_END