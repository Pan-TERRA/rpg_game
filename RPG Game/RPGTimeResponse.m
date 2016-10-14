//
//  RPGTimeResponse.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTimeResponse.h"

static NSString *const kRPGTimeResponseType = @"TIME_REQUEST";

@interface RPGTimeResponse ()

@property (retain, nonatomic, readwrite) NSDate *timestamp;

@end

@implementation RPGTimeResponse

#pragma mark - Init

- (instancetype)initWithTimestamp:(NSDate *)aTimestamp
{
  self = [super initWithType:kRPGTimeResponseType];
  
  if (self != nil)
  {
    _timestamp = [aTimestamp retain];
  }
  
  return self;
}

- (instancetype)initWithUnixTimestamp:(int)aUnixTimestamp
{
  //NSTimeInteval is typedef double
  NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)aUnixTimestamp];
  
  return [self initWithTimestamp:timestamp];
}

+ (instancetype)timeResponseWithTimestamp:(NSDate *)aTimestamp
{
  return [[[self alloc] initWithTimestamp:aTimestamp] autorelease];
}

+ (instancetype)timeResponseWithUnixTimestamp:(int)aTimestamp
{
  return [[[self alloc] initWithUnixTimestamp:aTimestamp] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_timestamp release];
  
  [super dealloc];
}

@end
