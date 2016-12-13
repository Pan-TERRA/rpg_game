//
//  RPGSkillRepresentation.m
//  RPG Game
//
//  Created by Владислав Крут on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillRepresentation.h"
  // Entities
#import "RPGSkillEffect.h"

static NSString * const kRPGSkillRepresentationName = @"name";
static NSString * const kRPGSkillRepresentationSkillDescription = @"description";
static NSString * const kRPGSkillRepresentationMultiplier = @"multiplier";
static NSString * const kRPGSkillRepresentationAbsoluteCooldown = @"cooldown";
static NSString * const kRPGSkillRepresentationImageName = @"imageName";
static NSString * const kRPGSkillRepresentationSoundName = @"soundName";
static NSString * const kRPGSkillRepresentationRequiredLevel = @"requiredLevel";
static NSString * const kRPGSkillRepresentationEffects = @"effects";

static NSString * const kRPGSkillRepresentationResourceName = @"RPGSkillsInfo";

@implementation RPGSkillRepresentation

#pragma mark - Init

- (instancetype)initWithSkillID:(NSInteger)aSkillID
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
      NSString *path = [[NSBundle mainBundle] pathForResource:kRPGSkillRepresentationResourceName
                                                       ofType:@"plist"];
      NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
      NSDictionary *skillDictionary = [plistDictionary valueForKey:[@(aSkillID) stringValue]];
      
      _name = [skillDictionary[kRPGSkillRepresentationName] copy];
      _skillDescription = [skillDictionary[kRPGSkillRepresentationSkillDescription] copy];
      _multiplier = [skillDictionary[kRPGSkillRepresentationMultiplier] floatValue];
      _cooldown = [skillDictionary[kRPGSkillRepresentationAbsoluteCooldown] integerValue];
      _imageName = [skillDictionary[kRPGSkillRepresentationImageName] copy];
      _soundName = [skillDictionary[kRPGSkillRepresentationSoundName] copy];
      _requiredLevel = [skillDictionary[kRPGSkillRepresentationRequiredLevel] integerValue];
      _effects = [skillDictionary[kRPGSkillRepresentationEffects] retain];
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithSkillID:-1];
}

+ (instancetype)skillrepresentationWithSkillID:(NSInteger)aSkillID
{
  return [[[self alloc] initWithSkillID:aSkillID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_name release];
  [_skillDescription release];
  [_imageName release];
  [_soundName release];
  [_effects release];
  
  [super dealloc];
}

@end
