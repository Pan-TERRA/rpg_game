//
//  RPGTimeResponse.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGTimeResponse.h"

NSString * const kRPGTimeResponseType = @"TIME_RESPONSE";
NSString * const kRPGTimeResponseSerializationTimestamp = @"time";

@interface RPGTimeResponse ()

@property (nonatomic, retain, readwrite) NSDate *timestamp;

@end

@implementation RPGTimeResponse

#pragma mark - Init

- (instancetype)initWithTimestamp:(NSDate *)aTimestamp
                           status:(RPGStatusCode)aStatus
{
  self = [super initWithType:kRPGTimeResponseType
                      status:aStatus];
  
  if (self != nil)
  {
    _timestamp = [aTimestamp retain];
  }
  
  return self;
}

- (instancetype)initWithUnixTimestamp:(int)aUnixTimestamp
                               status:(RPGStatusCode)aStatus
{
  //NSTimeInteval is typedef double
  NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)aUnixTimestamp];
  
  return [self initWithTimestamp:timestamp
                          status:aStatus];
}

+ (instancetype)timeResponseWithTimestamp:(NSDate *)aTimestamp
                                   status:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithTimestamp:aTimestamp
                                   status:aStatus] autorelease];
}

+ (instancetype)timeResponseWithUnixTimestamp:(int)aTimestamp
                                       status:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithUnixTimestamp:aTimestamp
                                       status:aStatus] autorelease];
}

- (instancetype)initWithType:(NSString *)aType
                      status:(RPGStatusCode)aStatus
{
  return [self initWithTimestamp:nil
                          status:aStatus];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_timestamp release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  if (self.timestamp != nil)
  {
    dictionaryRepresentation[kRPGTimeResponseSerializationTimestamp] = @([self.timestamp timeIntervalSince1970]);
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithUnixTimestamp:[aDictionary[kRPGTimeResponseSerializationTimestamp] intValue]
                              status:[aDictionary[kRPGResponseSerializationStatus] integerValue]];
}

@end
