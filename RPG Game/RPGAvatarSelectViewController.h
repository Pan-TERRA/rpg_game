//
//  RPGAvatarSelectViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 12/1/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPGAvatarSelectViewControllerDelegate <NSObject>

- (void)handleWrongTokenError;
- (void)handleDefaultError;
- (void)updateCharacterAvatar;

@end

@interface RPGAvatarSelectViewController : UIViewController

@property (nonatomic, assign, readwrite) id<RPGAvatarSelectViewControllerDelegate> delegate;

@end
