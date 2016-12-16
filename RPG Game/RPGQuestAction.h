//
//  RPGQuestAction.h
//  RPG Game
//
//  Created by Максим Шульга on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

/**
 * @typedef RPGQuestAction
 * @brief A list of quest actions. Used by RPGNetworkManager for routing.
 * @constant kRPGQuestActionTakeQuest A take quest action.
 * @constant kRPGQuestActionDeleteQuest A delete quest action.
 */
typedef NS_ENUM(NSUInteger, RPGQuestAction)
{
  kRPGQuestActionTakeQuest,
  kRPGQuestActionDeleteQuest
};
