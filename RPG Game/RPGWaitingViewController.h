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
@property (nonatomic, copy, readwrite) void (^completionHandler)(void);

/**
 *  Init modal window. 
 *  Completion handler is called on premature closing (when user closes window with a button)
 *
 *  @param aMessage          A message
 *  @param completionHandler A handler to call on premature window closing
 *
 *  @return An instanse
 */
- (instancetype)initWithMessage:(NSString *)aMessage completion:(void (^ __nullable)())completionHandler;

- (instancetype)initWithMessage:(NSString *)aMessage;

@end

NS_ASSUME_NONNULL_END