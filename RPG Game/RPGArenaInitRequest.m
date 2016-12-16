//
//  RPGArenaInitRequest.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaInitRequest.h"
  //
#import "RPGMessageTypes.h"

NSString * const kRPGArenaInitRequestSerializationSkills = @"skills";

@interface RPGArenaInitRequest ()

@property (nonatomic, retain, readwrite) NSArray<NSNumber *> *skillIDs;

@end

@implementation RPGArenaInitRequest

#pragma mark - Init

- (instancetype)initWithSkillIDs:(NSArray<NSNumber *> *)aSkillIDs
{
  self = [super initWithType:kRPGArenaInitMessageType];
  
  if (self != nil)
  {
    _skillIDs = [aSkillIDs retain];
  }
  
  return self;
}

+ (instancetype)requestWithSkillIDs:(NSArray<NSNumber *> *)aSkillIDs
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
  
  if (self.skillIDs != nil)
  {
    dictionaryRepresentation[kRPGArenaInitRequestSerializationSkills] = self.skillIDs;
  }
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithSkillIDs:aDictionary[kRPGArenaInitRequestSerializationSkills]];
}

@end
