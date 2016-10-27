//
//  RPGSkill.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSkill : NSObject

@property (assign, nonatomic, readonly) NSInteger skillID;
@property (assign, nonatomic, readwrite) NSInteger cooldown;

- (instancetype)initWithSkillID:(NSInteger)aSkillID cooldown:(NSInteger)aCooldown;
+ (instancetype)skillWithSkillID:(NSInteger)aSkillID cooldown:(NSInteger)aCooldown;

@end
