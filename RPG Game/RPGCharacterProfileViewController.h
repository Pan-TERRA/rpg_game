//
//  RPGCharacterProfileViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/16/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPGCharacterProfileViewController : UIViewController

- (void)addToBagCollectionSkillWithID:(NSUInteger)aSkillID;
- (void)addToSkillCollectionSkillWithID:(NSUInteger)aSkillID;

@end
