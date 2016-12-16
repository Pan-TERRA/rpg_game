//
//  RPGAvailableLocationsResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAvailableLocationsResponse.h"

static NSString * const kRPGAvailableLocationsResponseStatus = @"status";
static NSString * const kRPGAvailableLocationsResponseLocationsIDs = @"locations";

@implementation RPGAvailableLocationsResponse

#pragma mark - Init

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                  locationsIDs:(NSArray<NSNumber *> *)aLocationsIDs
{
  self = [super init];
  if (self != nil)
  {
    if (aLocationsIDs != nil)
    {
      _status = aStatus;
      _locationsIDs = [aLocationsIDs retain];
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  return self;
}

- (instancetype)init
{
  return [self initWithStatus:-1 locationsIDs:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_locationsIDs release];
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGAvailableLocationsResponseStatus] = @(self.status);
  dictionary[kRPGAvailableLocationsResponseLocationsIDs] = self.locationsIDs;
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGAvailableLocationsResponseStatus] integerValue]
                 locationsIDs:aDictionary[kRPGAvailableLocationsResponseLocationsIDs]];
}

@end
