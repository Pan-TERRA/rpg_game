//
//  RPGSkillInfoResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillInfoResponse.h"

static NSString * const kRPGSkillInfoResponseStatus = @"status";
static NSString * const kRPGSkillInfoResponseSkill = @"skill";

@implementation RPGSkillInfoResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)status skill:(NSDictionary *)skill
{
  self = [super init];
  if (self != nil)
  {
    _status = status;
    _skill = [[NSDictionary alloc] initWithDictionary:skill];
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skill release];
  [super dealloc];
}


#pragma mark - RPGSerializable 

- (NSDictionary *)dictionaryRepresentation
{
  return @{
           kRPGSkillInfoResponseStatus: @(self.status),
           kRPGSkillInfoResponseSkill: self.skill
           };
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGSkillInfoResponseStatus] integerValue]
                        skill:aDictionary[kRPGSkillInfoResponseSkill]];
}

@end
