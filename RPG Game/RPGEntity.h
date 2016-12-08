//
//  RPGEntity.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
  // Misc
#import "RPGSerializable.h"

extern NSString * const kRPGEntityName;
extern NSString * const kRPGEntityHP;
extern NSString * const kRPGEntityMaxHP;
extern NSString * const kRPGEntityLevel;

@class RPGSkillEffect;
/**
 *  Basic battle entity. Used by RPGBattle as opponent
 *  object.
 */
@interface RPGEntity : NSObject <RPGSerializable>

@property (copy, nonatomic, readwrite) NSString *name;
@property (assign, nonatomic, readwrite) NSInteger HP;
@property (assign, nonatomic, readwrite) NSInteger maxHP;
@property (assign, nonatomic, readwrite) NSInteger level;
@property (retain, nonatomic, readwrite) NSArray<RPGSkillEffect *> *skillsEffects;

- (instancetype)initWithName:(NSString *)aName
                          HP:(NSInteger)aHP
                       maxHP:(NSInteger)aMaxHP
                       level:(NSInteger)aLevel;
+ (instancetype)entityWithName:(NSString *)aName
                            HP:(NSInteger)aHP
                         maxHP:(NSInteger)aMaxHP
                         level:(NSInteger)aLevel;

@end
