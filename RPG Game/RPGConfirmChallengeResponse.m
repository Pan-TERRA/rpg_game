//
//  RPGConfirmChallengeResponse.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGConfirmChallengeResponse.h"

static NSString * const kRPGConfirmChallengeResponseStatus = @"status";

@interface RPGConfirmChallengeResponse()

@property (nonatomic, assign, readwrite) RPGStatusCode status;

@end

@implementation RPGConfirmChallengeResponse

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

+ (instancetype)confirmChallengeResponseWithStatus:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithStatus:aStatus] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGConfirmChallengeResponseStatus] = @(self.status);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGConfirmChallengeResponseStatus] integerValue]];
}

@end
