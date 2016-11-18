//
//  RPGWaitingViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPGWaitingViewController : UIViewController

@property (nonatomic, copy, readwrite) NSString *message;

- (instancetype)initWithMessage:(NSString *)aMessage;

@end
