//
//  RPGQuestListViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPGQuestListState.h"

@class RPGQuest;

extern NSString * const kRPGQuestStringStateInProgress;
extern NSString * const kRPGQuestStringStateNotReviewed;
extern NSString * const kRPGQuestStringStateReviewedFalse;

@interface RPGQuestListViewController : UIViewController

- (void)updateViewForState:(RPGQuestListState)aState willReload:(BOOL)aWillReloadFlag;
- (void)showQuestViewWithQuest:(RPGQuest *)aQuest;

@end
