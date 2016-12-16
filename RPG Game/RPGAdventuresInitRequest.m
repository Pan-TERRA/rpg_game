//
//  RPGAdventuresInitRequest.m
//  RPG Game
//
//  Created by Степан Супинский on 12/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAdventuresInitRequest.h"

static NSString * const kRPGAdventuresInitRequestStageID = @"stage_id";

@implementation RPGAdventuresInitRequest

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType stageID:(NSInteger)aStageID
{
  self = [super initWithType:aType];
  
  if (self != nil)
  {
    if (aStageID > 0)
    {
      _stageID = aStageID;
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (instancetype)initWithType:(NSString *)aType
{
  return [self initWithType:aType stageID:-1];
}

+ (instancetype)requestWithType:(NSString *)aType stageID:(NSInteger)aStageID
{
  return [[[self alloc] initWithType:aType stageID:aStageID] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [[super dictionaryRepresentation] mutableCopy];
  
  dictionary[kRPGAdventuresInitRequestStageID] = @(self.stageID);
  
  return [dictionary autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithType:aDictionary[kRPGRequestSerializationType]
                    stageID:[aDictionary[kRPGAdventuresInitRequestStageID] integerValue]];
}

@end
