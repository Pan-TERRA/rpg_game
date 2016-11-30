//
//  RPGSkillsRequest.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterRequest.h"

NSString * const kRPGCharacterRequestCharacterID = @"char_id";

@interface RPGCharacterRequest()

@property (nonatomic, assign, readwrite) NSInteger characterID;

@end

@implementation RPGCharacterRequest

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

+ (instancetype)characterRequestWithCharacterID:(NSInteger)aCharacterID
{
  return [[[self alloc] initWithCharacterID:aCharacterID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
  dictionary[kRPGCharacterRequestCharacterID] = @(self.characterID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithCharacterID:[aDictionary[kRPGCharacterRequestCharacterID] integerValue]];
}

@end
