//
//  RPGPlayer.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGEntity.h"
  // Misc
#import "RPGSerializable.h"
  // Entities
@class RPGSkill;

/**
 *  User battle entity. Used by RPGBattle as player object.
 */
@interface RPGPlayer : RPGEntity <RPGSerializable>

@property (nonatomic, retain, readwrite) NSArray<RPGSkill *> *skills;

@property (assign, nonatomic, readwrite) NSInteger currentWinCount;

- (instancetype)initWithName:(NSString *)aName
                          HP:(NSInteger)aHP
                       maxHP:(NSInteger)aMaxHP
                       level:(NSInteger)aLevel
                      skills:(NSArray<RPGSkill *> *)aSkills
             currentWinCount:(NSInteger)aCurrentWinCount NS_DESIGNATED_INITIALIZER;

+ (instancetype)playerWithName:(NSString *)aName
                            HP:(NSInteger)aHP
                         maxHP:(NSInteger)aMaxHP
                         level:(NSInteger)aLevel
                        skills:(NSArray<RPGSkill *> *)aSkills
               currentWinCount:(NSInteger)aCurrentWinCount;

- (RPGSkill *)skillByID:(NSInteger)anID;

@end
