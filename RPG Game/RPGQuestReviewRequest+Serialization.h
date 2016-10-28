//
//  RPGQuestReviewRequest+Serialization.h
//  RPG Game
//
//  Created by Максим Шульга on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReviewRequest.h"
#import "RPGSerializable.h"

@interface RPGQuestReviewRequest (Serialization) <RPGSerializable>

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
