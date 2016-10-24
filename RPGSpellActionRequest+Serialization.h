//
//  RPGSpellCondtion+Serialization.h
//  
//
//  Created by Иван Дзюбенко on 10/24/16.
//
//

#import "RPGSpellActionRequest.h"

@interface RPGSpellActionRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
