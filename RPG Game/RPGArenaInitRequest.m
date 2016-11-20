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

- (instancetype)initWithSkillIDs:(NSArray *)aSkillIDs token:(NSString *)aToken
{
  self = [super initWithType:kRPGArenaInitRequestType token:aToken];
  
  if (self != nil)
  {
    _skillIDs = [aSkillIDs retain];
  }
  
  return self;
}

+ (instancetype)requestWithSkillIDs:(NSArray *)aSkillIDs token:(NSString *)aToken
{
  return [[[self alloc] initWithSkillIDs:aSkillIDs token:aToken] autorelease];
}

- (instancetype)initWithType:(NSString *)aType token:(NSString *)aToken
{
  return [self initWithSkillIDs:nil token:nil];
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
  return [self initWithSkillIDs:skillIDs token:aDictionary[kRPGRequestSerializationToken]];
}

@end
