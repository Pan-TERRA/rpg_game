//
//  RPGQuestViewButtonContainerController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGQuest.h"

@class RPGQuestViewController;

@interface RPGQuestViewButtonContainer : UIView

@property (nonatomic, assign, readwrite) RPGQuestViewController *questViewController;

- (void)updateView;

@end
