//
//  RPGSkillsRequest.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsRequest.h"

static NSString * const kRPGSkillsRequestCharacterID = @"char_id";

@implementation RPGSkillsRequest

#pragma mark - Init

- (instancetype)initWithCharacterID:(NSInteger)characterID
{
  self = [super init];
  if (self != nil)
  {
    if (characterID >= 0)
    {
      _characterID = characterID;
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
  return [self initWithCharacterID:-1];
}

+ (instancetype)skillsRequestWithCharacterID:(NSInteger)aCharacterID
{
  return [[[self alloc] initWithCharacterID:aCharacterID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_token release];
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGSkillsRequestCharacterID] = @(self.characterID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithCharacterID:[aDictionary[kRPGSkillsRequestCharacterID] integerValue]];
}

@end
