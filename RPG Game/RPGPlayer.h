//
//  RPGPlayer.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGEntity.h"
#import "RPGSerializable.h"

@class RPGSkill;

extern NSString * const kRPGPlayerSkills;

@protocol RPGClientEntity <NSObject>

@property (retain, nonatomic, readwrite) NSArray<RPGSkill *> *skills;

@end

/**
 *  User battle entity. Used by RPGBattle as player object.
 */
@interface RPGPlayer : RPGEntity <RPGClientEntity, RPGSerializable>

@property (assign, nonatomic, readwrite) NSInteger currentWinCount;

- (instancetype)initWithName:(NSString *)aName
                          HP:(NSInteger)aHP
                       maxHP:(NSInteger)aMaxHP
                       level:(NSInteger)aLevel
                      skills:(NSArray<RPGSkill *> *)aSkills
             currentWinCount:(NSInteger)aCurrentWinCount;

+ (instancetype)playerWithName:(NSString *)aName
                            HP:(NSInteger)aHP
                         maxHP:(NSInteger)aMaxHP
                         level:(NSInteger)aLevel
                        skills:(NSArray<RPGSkill *> *)aSkills
               currentWinCount:(NSInteger)aCurrentWinCount;
//- (instancetype)initWithSkills:(NSArray<RPGSkill *> *)aSkills;
//+ (instancetype)playerWithSkills:(NSArray<RPGSkill *> *)aSkills;

- (RPGSkill *)skillByID:(NSInteger)anID;

@end
