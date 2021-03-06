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
  // Entities
@class RPGSkillEffect;

extern NSString * const kRPGEntityName;
extern NSString * const kRPGEntityHP;
extern NSString * const kRPGEntityMaxHP;
extern NSString * const kRPGEntityLevel;

/**
 *  Basic battle entity. Used by RPGBattle as opponent
 *  object.
 */
@interface RPGEntity : NSObject <RPGSerializable>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readwrite) NSInteger HP;
@property (nonatomic, assign, readonly) NSInteger maxHP;
@property (nonatomic, assign, readonly) NSInteger level;
@property (nonatomic, retain, readwrite) NSArray<RPGSkillEffect *> *skillsEffects;

- (instancetype)initWithName:(NSString *)aName
                          HP:(NSInteger)aHP
                       maxHP:(NSInteger)aMaxHP
                       level:(NSInteger)aLevel NS_DESIGNATED_INITIALIZER;
+ (instancetype)entityWithName:(NSString *)aName
                            HP:(NSInteger)aHP
                         maxHP:(NSInteger)aMaxHP
                         level:(NSInteger)aLevel;

@end
