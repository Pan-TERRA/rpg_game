//
//  RPGAvailableLocationsResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

@interface RPGAvailableLocationsResponse : NSObject <RPGSerializable>

- (instancetype)initWithStatus:(NSInteger)aStatus
                  locationsIDs:(NSArray<NSNumber *> *)aLocationsIDs NS_DESIGNATED_INITIALIZER;

@property (readwrite, assign, nonatomic) NSInteger status;
@property (readwrite, retain, nonatomic) NSArray<NSNumber *> *locationsIDs;

@end
