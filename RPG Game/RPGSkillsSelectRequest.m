  //
  //  RPGSkillSelectRequest.m
  //  RPG Game
  //
  //  Created by Максим Шульга on 11/17/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGSkillsSelectRequest.h"

static NSString * const kRPGSkillsSelectRequestSkillsIDArray = @"skills";

@interface RPGSkillsSelectRequest()

@property (nonatomic, retain, readwrite) NSArray *skillsID;

@end

@implementation RPGSkillsSelectRequest

#pragma mark - Init

- (instancetype)initWithCharacterID:(NSInteger)characterID
                             skills:(NSArray *)aSkills
{
  self = [super initWithCharacterID:characterID];
  
  if (self != nil)
  {
    if (aSkills != nil)
    {
      _skillsID = [aSkills retain];
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
  return [self initWithCharacterID:-1
                            skills:nil];
}

- (instancetype)initWithCharacterID:(NSInteger)aCharacterID
{
  return [self initWithCharacterID:-1
                            skills:nil];
}

+ (instancetype)skillSelectRequestWithCharacterID:(NSInteger)aCharacterID
                                           skills:(NSArray *)aSkills
{
  return [[[self alloc] initWithCharacterID:aCharacterID
                                     skills:aSkills] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsID release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  if (self.skillsID != nil)
  {
    dictionary[kRPGSkillsSelectRequestSkillsIDArray] = self.skillsID;
  }
  dictionary[kRPGCharacterRequestCharacterID] = @(self.characterID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithCharacterID:[aDictionary[kRPGCharacterRequestCharacterID] integerValue]
                            skills:aDictionary[kRPGSkillsSelectRequestSkillsIDArray]];
}

@end
