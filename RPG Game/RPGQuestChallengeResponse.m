//
//  RPGQuestChallengeResponse.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestChallengeResponse.h"

static NSString * const kRPGQuestChallengeResponseStatus = @"status";

@interface RPGQuestChallengeResponse()

@property (nonatomic, assign, readwrite) RPGStatusCode status;

@end

@implementation RPGQuestChallengeResponse

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

+ (instancetype)questChallengeResponseWithStatus:(RPGStatusCode)aStatus
{
  return [[[self alloc] initWithStatus:aStatus] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGQuestChallengeResponseStatus] = @(self.status);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGQuestChallengeResponseStatus] integerValue]];
}

@end
