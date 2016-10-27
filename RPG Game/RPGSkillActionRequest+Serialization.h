//
//  RPGSkillActionRequest+Serialization.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/27/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillActionRequest.h"

@interface RPGSkillActionRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
