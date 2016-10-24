//
//  RPGPlayer.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGEntity.h"

@protocol RPGClientEntity <NSObject>

@property (retain, nonatomic, readonly) NSArray *spells;

@end

@interface RPGPlayer : RPGEntity <RPGClientEntity>

- (instancetype)initWithSpells:(NSArray *)aSpells;
+ (instancetype)playerWithSpells:(NSArray *)aSpells;

@end
