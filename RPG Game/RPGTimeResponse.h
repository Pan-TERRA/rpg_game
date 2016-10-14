//
//  RPGTimeResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@interface RPGTimeResponse : RPGResponse

@property (retain, nonatomic, readonly) NSDate *timestamp;

#pragma mark - Init

- (instancetype)initWithTimestamp:(NSDate *)aTimestamp;
+ (instancetype)timeResponseWithTimestamp:(NSDate *)aTimestamp;
- (instancetype)initWithUnixTimestamp:(int)aTimestamp;
+ (instancetype)timeResponseWithUnixTimestamp:(int)aTimestamp;

@end
