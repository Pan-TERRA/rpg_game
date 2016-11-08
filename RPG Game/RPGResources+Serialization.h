//
//  RPGResources+Serialization.h
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResources.h"

extern NSString * const kRPGResourcesGold;
extern NSString * const kRPGResourcesCrystals;

@interface RPGResources (Serialization) 

- (NSDictionary *)dictionaryRepresentation;
- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary;

@end
