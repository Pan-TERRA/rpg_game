//
//  RPGArenaSkillsResponse.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaSkillsResponse.h"

static NSString * const kRPGArenaSkillsResponseStatus = @"status";
static NSString * const kRPGArenaSkillsResponseSkills = @"skills";

@interface RPGArenaSkillsResponse()

@property (nonatomic, assign, readwrite) NSInteger status;
@property (nonatomic, retain, readwrite) NSArray<NSNumber *> *skills;

@end

@implementation RPGArenaSkillsResponse

#pragma mark - Init

- (instancetype)initWithStatus:(NSInteger)aStatus
                        skills:(NSArray<NSNumber *> *)aSkills
{
  self = [super init];
  
  if (self != nil)
  {
    if (aStatus != -1 && aSkills != nil)
    {
      _status = aStatus;
      _skills = [aSkills retain];
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithStatus:-1
                       skills:nil];
}

+ (instancetype)responseWithStatus:(NSInteger)aStatus
                            skills:(NSArray<NSNumber *> *)aSkills
{
  return [[[self alloc] initWithStatus:aStatus
                               skills:aSkills] autorelease];
}
#pragma mark - Dealloc

- (void)dealloc
{
  [_skills release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGArenaSkillsResponseStatus] = @(self.status);
  
  if (self.skills != nil)
  {
    dictionary[kRPGArenaSkillsResponseSkills] = self.skills;
  }
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGArenaSkillsResponseStatus] integerValue]
                       skills:aDictionary[kRPGArenaSkillsResponseSkills]];
}

@end
