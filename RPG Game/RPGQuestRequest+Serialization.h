//
//  RPGQuestRequest+Serialization.h
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestRequest.h"

@interface RPGQuestRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
