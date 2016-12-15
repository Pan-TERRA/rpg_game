//
//  RPGSkillEffectRepresentation.m
//  RPG Game
//
//  Created by Максим Шульга on 12/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillEffectRepresentation.h"

static NSString * const kRPGSkillEffectRepresentationDuration = @"duration";
static NSString * const kRPGSkillEffectRepresentationName = @"name";
static NSString * const kRPGSkillEffectRepresentationSkillDescription = @"description";
static NSString * const kRPGSkillEffectRepresentationImageName = @"imageName";

static NSString * const kRPGSkillEffectRepresentationResourceName = @"RPGSkillsEffectsInfo";

@implementation RPGSkillEffectRepresentation

#pragma mark - Init

- (instancetype)initWithSkillEffectID:(NSInteger)aSkillEffectID
{
  self = [super init];
  
  if (self != nil)
  {
    if (aSkillEffectID < 1)
    {
      [self release];
      self = nil;
    }
    else
    {
      NSString *path = [[NSBundle mainBundle] pathForResource:kRPGSkillEffectRepresentationResourceName
                                                       ofType:@"plist"];
      NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
      NSDictionary *skillEffectDictionary = [plistDictionary valueForKey:[@(aSkillEffectID) stringValue]];
      
      _duration = [skillEffectDictionary[kRPGSkillEffectRepresentationDuration] integerValue];
      _name = [skillEffectDictionary[kRPGSkillEffectRepresentationName] copy];
      _skillEffectDescription = [skillEffectDictionary[kRPGSkillEffectRepresentationSkillDescription] copy];
      _imageName = [skillEffectDictionary[kRPGSkillEffectRepresentationImageName] copy];
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithSkillEffectID:-1];
}

+ (instancetype)skillEffectRepresentationWithSkillEffectID:(NSInteger)aSkillEffectID
{
  return [[[self alloc] initWithSkillEffectID:aSkillEffectID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_name release];
  [_skillEffectDescription release];
  [_imageName release];
  
  [super dealloc];
}

@end
