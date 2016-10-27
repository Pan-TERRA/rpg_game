//
//  RPGBattleConditionResponse+Serialization.h
//  RPG Game
//
//  Created by Степан Супинский on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleConditionResponse.h"

@interface RPGBattleConditionResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
