//
//  RPGSpell+Serialization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSpell.h"

extern NSString * const kRPGSpellID;
extern NSString * const kRPGSpellCooldown;

@interface RPGSpell (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
