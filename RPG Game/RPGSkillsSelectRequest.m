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

- (instancetype)initWithToken:(NSString *)aToken
                  characterID:(NSInteger)characterID
                       skills:(NSArray *)aSkills
{
  self = [super initWithToken:aToken characterID:characterID];
  
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
  return [self initWithToken:nil
                 characterID:-1
                      skills:nil];
}

- (instancetype)initWithToken:(NSString *)aToken
                  characterID:(NSInteger)aCharacterID
{
  return [self initWithToken:nil
                 characterID:-1
                      skills:nil];
}

+ (instancetype)skillSelectRequestWithToken:(NSString *)aToken
                                characterID:(NSInteger)aCharacterID
                                     skills:(NSArray *)aSkills
{
  return [[[self alloc] initWithToken:aToken
                          characterID:aCharacterID
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
  
  if (self.token != nil)
  {
    dictionary[kRPGCharacterRequestToken] = self.token;
  }
  if (self.skillsID != nil)
  {
    dictionary[kRPGSkillsSelectRequestSkillsIDArray] = self.skillsID;
  }
  dictionary[kRPGCharacterRequestCharacterID] = @(self.characterID);
  
  return dictionary;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithToken:aDictionary[kRPGCharacterRequestToken]
                 characterID:[aDictionary[kRPGCharacterRequestCharacterID] integerValue]
                      skills:aDictionary[kRPGSkillsSelectRequestSkillsIDArray]];
}

@end
