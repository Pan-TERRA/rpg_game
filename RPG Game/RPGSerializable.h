//
//  RPGSerializable.h
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/26/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

@protocol RPGSerializable <NSObject>

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
