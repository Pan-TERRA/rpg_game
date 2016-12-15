//
//  RPGAddFriendViewController.h
//  RPG Game
//
//  Created by Владислав Крут on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RPGAddFriendViewController;

@protocol RPGAddFriendViewControllerDelegate <NSObject>

- (void)friendDidAdd:(RPGAddFriendViewController *)anAddFriendViewController;

@end

@interface RPGAddFriendViewController : UIViewController

@property (nonatomic, assign, readwrite) id<RPGAddFriendViewControllerDelegate> delegate;

@end
