//
//  RPGClassesResponse.h
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPGClassesResponse : NSObject

@property (assign, nonatomic, readwrite) NSInteger status;
@property (copy, nonatomic, readwrite) NSArray *classes;

- (instancetype)initWithStatus:(NSInteger)status classes:(NSArray *)classes;

@end
