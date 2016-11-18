//
//  RPGSkill.h
//  RPG Game
//
//  Created by Владислав Крут on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSkill : NSObject

@property (nonatomic, assign, readonly) NSInteger skillID;
@property (nonatomic, assign, readwrite) NSInteger cooldown;

- (instancetype)initWithSkillID:(NSInteger)aSkillID;
+ (instancetype)skillWithSkillID:(NSInteger)aSkillID;

- (instancetype)initWithSkillID:(NSInteger)aSkillID cooldown:(NSInteger)aCooldown;
+ (instancetype)skillWithSkillID:(NSInteger)aSkillID cooldown:(NSInteger)aCooldown;

@end
