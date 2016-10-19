//
//  RPGQuestListViewController.h
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

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

extern NSString * const kRPGQuestTitle;
extern NSString * const kRPGQuestDescription;
extern NSString * const kRPGQuestReward;
extern NSString * const kRPGQuestState;

extern NSString * const kRPGQuestStringStateInProgress;
extern NSString * const kRPGQuestStringStateNotReviewed;
extern NSString * const kRPGQuestStringStateReviewedFalse;

@interface RPGQuestListViewController : UIViewController

@end