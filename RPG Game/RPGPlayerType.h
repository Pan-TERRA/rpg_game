//
//  RPGPlayerType.h
//  RPG Game
//
//  Created by Максим Шульга on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

/**
 * @typedef RPGPlayerType
 * @brief A list of player roles. Used by RPGSkillsEffectsViewController to define datasource.
 * @constant kRPGPlayerTypeNull No player.
 * @constant kRPGPlayerTypePlayer A player.
 * @constant kRPGPlayerTypeOpponent An opponent.
 */
typedef NS_ENUM(NSUInteger, RPGPlayerType)
{
  kRPGPlayerTypeNull,
  kRPGPlayerTypePlayer,
  kRPGPlayerTypeOpponent
};
