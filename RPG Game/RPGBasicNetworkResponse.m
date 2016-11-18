//
//  RPGBasicNetworkResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 11/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBasicNetworkResponse.h"

static NSString * const kRPGBasicNetworkResponseStatus = @"status";

@implementation RPGBasicNetworkResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
{
  self = [super init];
  if (self != nil)
  {
    _status = aStatus;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithStatus:-1];
}

+ (instancetype)responseWithStatus:(NSInteger)aStatus
{
  return [[[self alloc] initWithStatus:aStatus] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGBasicNetworkResponseStatus] = @(self.status);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  id instance = nil;
  
  if (aDictionary[kRPGBasicNetworkResponseStatus] != nil
      && aDictionary[kRPGBasicNetworkResponseStatus] != [NSNull null])
  {
    instance = [self initWithStatus:[aDictionary[kRPGBasicNetworkResponseStatus] integerValue]];
  }
  
  return instance;
}

@end
