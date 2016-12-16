//
//  RPGSkill.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterProfileSkill.h"

NSString * const kRPGSkillID = @"skill_id";
NSString * const kRPGSkillSelected = @"is_selected";

@interface RPGCharacterProfileSkill()

@property (nonatomic, assign, readwrite) NSInteger skillID;

@end

@implementation RPGCharacterProfileSkill

- (instancetype)initWithID:(NSInteger)aSkillID
                  selected:(BOOL)isSelected
{
  self = [super init];
  
  if (self != nil)
  {
    if (aSkillID < 1)
    {
      [self release];
      self = nil;
    }
    else
    {
      _skillID = aSkillID;
      _selected = isSelected;
    }
  }
  
  return self;
}

+ (instancetype)skillWithID:(NSInteger)aSkillID
                   selected:(BOOL)isSelected
{
  return [[[self alloc] initWithID:aSkillID
                          selected:isSelected] autorelease];
}

- (instancetype)init
{
  return [self initWithID:-1
                 selected:NO];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGSkillID] = @(self.skillID);
  dictionaryRepresentation[kRPGSkillSelected] = @(self.isSelected);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithID:[aDictionary[kRPGSkillID] integerValue]
                 selected:[aDictionary[kRPGSkillSelected] boolValue]];
}

@end
