//
//  RPGQuestViewHeaderContainer.h
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Views
@class RPGQuestViewController;
  // Entities
@class RPGQuestReward;

@interface RPGQuestViewHeaderContainer : UIView

@property (nonatomic, assign, readwrite) RPGQuestViewController *questViewController;

- (void)setViewContent:(RPGQuestReward *)aQuestReward;
- (void)updateView;

@end
