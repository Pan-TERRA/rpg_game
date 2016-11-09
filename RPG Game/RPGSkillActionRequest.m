//
//  RPGSkillCondtion.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillActionRequest.h"
#import "RPGRequest.h"

NSString * const kRPGSkillActionRequestType = @"SKILL_ACTION";

@implementation RPGSkillActionRequest

#pragma mark - Init

- (instancetype)initWithSkillID:(NSInteger)aSkillID token:(NSString *)aToken
{
  self = [super initWithType:kRPGSkillActionRequestType token:aToken];
  
  if (self != nil)
  {
    _skillID = aSkillID;
  }
  
  return self;
}

+ (instancetype)requestWithSkillID:(NSInteger)aSkillID token:(NSString *)aToken
{
  return [[[self alloc] initWithSkillID:aSkillID token:aToken] autorelease];
}

- (instancetype)initWithType:(NSString *)aType token:(NSString *)aToken
{
  return [self initWithSkillID:-1 token:nil];
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
  return [self initWithSkillID:skllID token:aDictionary[kRPGRequestSerializationToken]];
}

@end
