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

static NSString * const kRPGQuestTitle = @"title";
static NSString * const kRPGQuestDescription = @"description";
static NSString * const kRPGQuestReward = @"reward";
static NSString * const kRPGQuestState = @"state";

static NSString * const kRPGQuestStringStateInProgress = @"In progress";
static NSString * const kRPGQuestStringStateNotReviewed = @"Not reviewed";
static NSString * const kRPGQuestStringStateReviewedFalse = @"Reviewed false";

@interface RPGQuestListViewController : UIViewController

@end