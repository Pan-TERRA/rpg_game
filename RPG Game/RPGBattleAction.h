//
//  RPGBattleAction.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Model entity. Represents single player's move.
 *  Used by RPGBattleLog as element of array.
 */
@interface RPGBattleAction : NSObject

@property (nonatomic, assign, readonly, getter=isMyTurn) BOOL myTurn;
@property (nonatomic, assign, readonly) NSInteger skillID;
@property (nonatomic, assign, readonly) NSInteger damage;

- (instancetype)initWithMyTurn:(BOOL)myTurn
                       skillID:(NSInteger)skillID
                        damage:(NSInteger)damage NS_DESIGNATED_INITIALIZER;

@end
