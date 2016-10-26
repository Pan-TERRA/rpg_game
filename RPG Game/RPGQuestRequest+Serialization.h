//
//  RPGQuestRequest+Serialization.h
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestRequest.h"
#import "RPGSerializable.h"

@interface RPGQuestRequest (Serialization) <RPGSerializable>

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
