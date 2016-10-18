//
//  RPGQuestListResponse+Serialization.h
//  RPG Game
//
//  Created by Максим Шульга on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListResponse.h"

@interface RPGQuestListResponse (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end