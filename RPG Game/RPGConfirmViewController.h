//
//  RPGConfirmViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPGConfirmViewController : UIViewController

@property (nonatomic, copy, readwrite) NSString *question;
@property (nonatomic, copy, readwrite, nullable) void (^completionHandler)(void);

- (instancetype)initWithQuestion:(NSString *)aQuestion completion:(void (^ __nullable)())completionHandler;

@end

NS_ASSUME_NONNULL_END
