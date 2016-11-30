//
//  RPGFriendAddResponse.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendAddResponse.h"

static NSString * const kRPGAddFriendResponseStatus = @"status";

@interface RPGFriendAddResponse()

@property (nonatomic, assign, readwrite) RPGStatusCode status;

@end

@implementation RPGFriendAddResponse

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
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
  return [self initWithStatus:kRPGStatusCodeDefaultError];
}

+ (instancetype)addFriendResponseWithStatus:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithStatus:aStatus] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGAddFriendResponseStatus] = @(self.status);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGAddFriendResponseStatus] integerValue]];
}

@end
