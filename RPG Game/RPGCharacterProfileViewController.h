//
//  RPGCharacterProfileViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/16/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPGCharacterProfileViewController : UIViewController

- (void)addToSkillCollectionSkillWithID:(NSUInteger)aSkillID;
- (void)addToBagCollectionSkillWithID:(NSUInteger)aSkillID;

@end
