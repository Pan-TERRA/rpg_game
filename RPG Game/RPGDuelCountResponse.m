//
//  RPGDuelCountResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 12/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGDuelCountResponse.h"

static NSString * const kRPGDuelCountResponseDuelQuestsStatus = @"status";
static NSString * const kRPGDuelCountResponseDuelQuestsCount = @"active_duels";

@interface RPGDuelCountResponse ()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, assign, readwrite) NSInteger duelQuestsCount;

@end

@implementation RPGDuelCountResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
               duelQuestsCount:(NSInteger)aCount
{
  self = [super init];
  
  if (self != nil)
  {
    if (aCount < 0)
    {
      [self release];
      self = nil;
    }
    else
    {
      _duelQuestsCount = aCount;
    }
  }
  
  return self;
}

+ (instancetype)duelCountResponseWithStatus:(NSInteger)aStatus
                            duelQuestsCount:(NSInteger)aCount
{
  return [[[self alloc] initWithStatus:aStatus
                       duelQuestsCount:aCount] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:-1
              duelQuestsCount:-1];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGDuelCountResponseDuelQuestsStatus] = @(self.status);
  dictionaryRepresentation[kRPGDuelCountResponseDuelQuestsCount] = @(self.duelQuestsCount);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGDuelCountResponseDuelQuestsStatus] integerValue]
              duelQuestsCount:[aDictionary[kRPGDuelCountResponseDuelQuestsCount] integerValue]];
}

@end
