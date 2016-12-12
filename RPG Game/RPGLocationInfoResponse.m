//
//  RPGLocationInfoResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGLocationInfoResponse.h"

static NSString * const kRPGLocationInfoResponseStatus = @"status";
static NSString * const kRPGLocationInfoResponseLocationInfo = @"location_info";

@implementation RPGLocationInfoResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
                  locationInfo:(NSArray<NSDictionary *> *)aLocationInfo
{
  self = [super init];
  if (self != nil)
  {
    if (aStatus >= 0 && aLocationInfo != nil)
    {
      _status = aStatus;
      _locationInfo = aLocationInfo;
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
  return [self initWithStatus:-1 locationInfo:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_locationInfo release];
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGLocationInfoResponseStatus] = @(self.status);
  dictionary[kRPGLocationInfoResponseLocationInfo] = self.locationInfo;
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGLocationInfoResponseStatus] integerValue]
                 locationInfo:aDictionary[kRPGLocationInfoResponseLocationInfo]];
}

@end
