//
//  RPGTimeResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@interface RPGTimeResponse : RPGResponse

@property (nonatomic, retain, readonly) NSDate *timestamp;

#pragma mark - Init

- (instancetype)initWithTimestamp:(NSDate *)aTimestamp
                           status:(NSInteger)aStatus;
- (instancetype)initWithUnixTimestamp:(int)aTimestamp
                               status:(NSInteger)aStatus;
+ (instancetype)timeResponseWithTimestamp:(NSDate *)aTimestamp
                                   status:(NSInteger)aStatus;
+ (instancetype)timeResponseWithUnixTimestamp:(int)aTimestamp
                                       status:(NSInteger)aStatus;

@end