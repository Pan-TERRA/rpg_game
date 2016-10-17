//
//  RPGTimeResponse.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTimeResponse.h"

NSString *const kRPGTimeResponseType = @"TIME_REQUEST";

@interface RPGTimeResponse ()

@property (retain, nonatomic, readwrite) NSDate *timestamp;

@end

@implementation RPGTimeResponse

#pragma mark - Init

- (instancetype)initWithTimestamp:(NSDate *)aTimestamp status:(int)aStatus
{
  self = [super initWithType:kRPGTimeResponseType status:aStatus];
  
  if (self != nil)
  {
    _timestamp = [aTimestamp retain];
  }
  
  return self;
}

- (instancetype)initWithUnixTimestamp:(int)aUnixTimestamp status:(int)aStatus
{
  //NSTimeInteval is typedef double
  NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)aUnixTimestamp];
  
  return [self initWithTimestamp:timestamp status:aStatus];
}

+ (instancetype)timeResponseWithTimestamp:(NSDate *)aTimestamp status:(int)aStatus
{
  return [[[self alloc] initWithTimestamp:aTimestamp status:aStatus] autorelease];
}

+ (instancetype)timeResponseWithUnixTimestamp:(int)aTimestamp status:(int)aStatus
{
  return [[[self alloc] initWithUnixTimestamp:aTimestamp status:aStatus] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_timestamp release];
  
  [super dealloc];
}

@end
