//
//  RPGEntity.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

extern NSString * const kRPGEntityName;
extern NSString * const kRPGEntityHP;

/**
 *  Basic battle entity. Used by RPGBattle as opponent
 *  object.
 */
@interface RPGEntity : NSObject <RPGSerializable>

@property (copy, nonatomic, readwrite) NSString *name;
@property (assign, nonatomic, readwrite) NSInteger HP;

- (instancetype)initWithName:(NSString *)aName HP:(NSInteger)aHP;
+ (instancetype)entityWithName:(NSString *)aName HP:(NSInteger)aHP;

@end
