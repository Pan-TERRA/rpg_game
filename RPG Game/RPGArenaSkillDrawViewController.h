//
//  RPGArenaSkillDrawViewController.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/20/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGBattlePresentingViewControllerProtocol.h"

@interface RPGArenaSkillDrawViewController : UIViewController

@property (nonatomic, assign, readwrite) id<RPGBattlePresentingViewController> delegate;

- (void)addSkillToSkillCollectionWithID:(NSUInteger)aSkillID;

@end
