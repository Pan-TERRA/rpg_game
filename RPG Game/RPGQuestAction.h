//
//  RPGQuestAction.h
//  RPG Game
//
//  Created by Максим Шульга on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

/**
 * @typedef OldCarType
 * @brief A list of older car types.
 * @constant OldCarTypeModelT A cool old car.
 * @constant OldCarTypeModelA A sophisticated old car.
 */
typedef NS_ENUM(NSUInteger, RPGQuestAction)
{
  kRPGQuestActionTakeQuest,
  kRPGQuestActionDeleteQuest
};
