//
//  RPGQuestListViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGQuestListState.h"

@class RPGQuest;

extern NSString * const kRPGQuestStringStateInProgress;
extern NSString * const kRPGQuestStringStateNotReviewed;
extern NSString * const kRPGQuestStringStateReviewedFalse;

@interface RPGQuestListViewController : UIViewController
/**
 *  Update the quest list table view.
 *
 *  @param aState            A qust list state.
 *  @param aShouldReloadFlag A flag that indicates whether to perform 
 *         reloadData method on table or not.
 */
- (void)updateViewForState:(RPGQuestListState)aState shouldReload:(BOOL)aShouldReloadFlag;
- (void)showQuestViewWithQuest:(RPGQuest *)aQuest;
- (void)setViewForNoQuests:(BOOL)aFlag;

@end
