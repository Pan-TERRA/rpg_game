//
//  RPGArenaInitRequest.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaInitRequest.h"

NSString * const kRPGArenaInitRequestType = @"ARENA_INIT";
NSString * const kRPGArenaInitRequestSerializationSkills = @"skills";

@interface RPGArenaInitRequest ()

@property (nonatomic, retain, readwrite) NSArray *skillIDs;

@end

@implementation RPGArenaInitRequest

#pragma mark - Init

- (instancetype)initWithSkillIDs:(NSArray *)aSkillIDs
{
  self = [super initWithType:kRPGArenaInitRequestType];
  
  if (self != nil)
  {
    _skillIDs = [aSkillIDs retain];
  }
  
  return self;
}

+ (instancetype)requestWithSkillIDs:(NSArray *)aSkillIDs
{
  return [[[self alloc] initWithSkillIDs:aSkillIDs] autorelease];
}

- (instancetype)initWithType:(NSString *)aType
{
  return [self initWithSkillIDs:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillIDs release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  dictionaryRepresentation[kRPGArenaInitRequestSerializationSkills] = self.skillIDs;
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSArray *skillIDs = aDictionary[kRPGArenaInitRequestSerializationSkills];
  return [self initWithSkillIDs:skillIDs];
}

@end
