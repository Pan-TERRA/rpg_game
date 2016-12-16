//
//  RPGTimeResponse.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"
  // Constants
#import "RPGStatusCodes.h"

extern NSString * const kRPGTimeResponseType;

@interface RPGTimeResponse : RPGResponse

@property (nonatomic, retain, readonly) NSDate *timestamp;

#pragma mark - Init

- (instancetype)initWithTimestamp:(NSDate *)aTimestamp
                           status:(RPGStatusCode)aStatus NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithUnixTimestamp:(int)aTimestamp
                               status:(RPGStatusCode)aStatus;
+ (instancetype)timeResponseWithTimestamp:(NSDate *)aTimestamp
                                   status:(RPGStatusCode)aStatus;
+ (instancetype)timeResponseWithUnixTimestamp:(int)aTimestamp
                                       status:(RPGStatusCode)aStatus;

@end
