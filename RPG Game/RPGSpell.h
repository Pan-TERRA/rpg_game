//
//  RPGSpell.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGSpell : NSObject

@property (assign, nonatomic, readonly) NSInteger spellID;
@property (assign, nonatomic, readwrite) NSInteger cooldown;

- (instancetype)initWithSpellID:(NSInteger)aSpellID cooldown:(NSInteger)aCooldown;
+ (instancetype)spellWithSpellID:(NSInteger)aSpellID cooldown:(NSInteger)aCooldown;

@end
