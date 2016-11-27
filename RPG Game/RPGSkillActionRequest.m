//
//  RPGSkillCondtion.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillActionRequest.h"
  // Entities
#import "RPGRequest.h"

NSString * const kRPGSkillActionRequestType = @"SKILL_ACTION";

@implementation RPGSkillActionRequest

#pragma mark - Init

- (instancetype)initWithSkillID:(NSInteger)aSkillID
{
  self = [super initWithType:kRPGSkillActionRequestType];
  
  if (self != nil)
  {
    _skillID = aSkillID;
  }
  
  return self;
}

+ (instancetype)requestWithSkillID:(NSInteger)aSkillID
{
  return [[[self alloc] initWithSkillID:aSkillID] autorelease];
}

- (instancetype)initWithType:(NSString *)aType
{
  return [self initWithSkillID:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
    // !!!: change to proper constant
    //  dictionaryRepresentation[kRPGSkillID] = @(self.skillID);
  dictionaryRepresentation[@"skill_id"] = @(self.skillID);
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSInteger skllID = [aDictionary[@"skill_id"] integerValue];
  return [self initWithSkillID:skllID];
}

@end
