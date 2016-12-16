//
//  RPGQuestEnum.h
//  RPG Game
//
//  Created by Максим Шульга on 12/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

typedef NS_ENUM(NSUInteger, RPGQuestState)
{
  kRPGQuestStateCanTake,
  kRPGQuestStateInProgress,
  // TODO: rename
  kRPGQuestStateDone,
  kRPGQuestStateReviewedTrue,
  kRPGQuestStateReviewedFalse,
  kRPGQuestStateForReview = 6 // ???: sho
};

typedef NS_ENUM(NSUInteger, RPGQuestType)
{
  kRPGQuestTypeSingle,
  kRPGQuestTypeDuel
};
