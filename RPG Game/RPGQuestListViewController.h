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
  kRPGQuestStateHide
};

@interface RPGQuestListViewController : UIViewController

@end