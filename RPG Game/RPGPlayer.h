//
//  RPGPlayer.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGEntity.h"

@protocol RPGClientEntity <NSObject>

@property (retain, nonatomic, readonly) NSArray *skills;

@end

@interface RPGPlayer : RPGEntity <RPGClientEntity>

- (instancetype)initWithSkills:(NSArray *)aSkills;
+ (instancetype)playerWithSkills:(NSArray *)aSkills;

@end
