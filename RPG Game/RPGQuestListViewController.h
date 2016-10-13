//
//  RPGQuestListViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RPGQuestListViewState)
{
  kRPGQuestListViewTakeQuest,
  kRPGQuestListViewInProgressQuest,
  kRPGQuestListViewDoneQuest,
  kRPGQuestListViewReviewQuest
};

typedef NS_ENUM(NSUInteger, RPGQuestState)
{
  kRPGQuestStateCanTake,
  kRPGQuestStateInProgress,
  kRPGQuestStateDone,
  kRPGQuestStateReviewedFalse,
  kRPGQuestStateReviewedTrue,
  kRPGQuestStateHide,
  kRPGQuestStateForReview
};

static NSString *const kRPGQuestListViewControllerQuestTitle = @"title";
static NSString *const kRPGQuestListViewControllerQuestDescription = @"description";
static NSString *const kRPGQuestListViewControllerQuestReward = @"reward";
static NSString *const kRPGQuestListViewControllerQuestState = @"state";

@interface RPGQuestListViewController : UIViewController

@end