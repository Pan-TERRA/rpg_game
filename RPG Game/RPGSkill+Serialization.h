//
//  RPGSkill+Serialization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkill.h"

extern NSString * const kRPGSkillID;
extern NSString * const kRPGSkillCooldown;

@interface RPGSkill (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
