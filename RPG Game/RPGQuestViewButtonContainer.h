//
//  RPGQuestViewButtonContainerController.h
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Views
@class RPGQuestViewController;
  // Entites
#import "RPGQuest.h"

@interface RPGQuestViewButtonContainer : UIView

@property (nonatomic, assign, readwrite) RPGQuestViewController *questViewController;

- (void)updateView;

@end
