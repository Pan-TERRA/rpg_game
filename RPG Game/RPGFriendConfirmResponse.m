//
//  RPGFriendConfirmResponse.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendConfirmResponse.h"

static NSString * const kRPGFriendConfirmResponseStatus = @"status";

@interface RPGFriendConfirmResponse()

@property (nonatomic, assign, readwrite) RPGStatusCode status;

@end

@implementation RPGFriendConfirmResponse

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

+ (instancetype)confirmFriendResponseWithStatus:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithStatus:aStatus] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGFriendConfirmResponseStatus] = @(self.status);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGFriendConfirmResponseStatus] integerValue]];
}

@end
