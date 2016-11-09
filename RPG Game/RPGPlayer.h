//
//  RPGPlayer.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGEntity.h"
#import "RPGSerializable.h"

extern NSString * const kRPGPlayerSkills;

@protocol RPGClientEntity <NSObject>

@property (retain, nonatomic, readonly) NSArray<NSNumber *> *skills;

@end

/**
 *  User battle entity. Used by RPGBattle as player object.
 */
@interface RPGPlayer : RPGEntity <RPGClientEntity, RPGSerializable>

- (instancetype)initWithSkills:(NSArray<NSNumber *> *)aSkills;
+ (instancetype)playerWithSkills:(NSArray<NSNumber *> *)aSkills;

@end
