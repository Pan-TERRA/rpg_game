//
//  RPGSkillEffectRepresentation.m
//  RPG Game
//
//  Created by Максим Шульга on 12/9/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillEffectRepresentation.h"

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
      NSDictionary *skillDictionary = [plistDictionary valueForKey:[@(aSkillEffectID) stringValue]];
      
      _name = [skillDictionary[kRPGSkillEffectRepresentationName] copy];
      _skillEffectDescription = [skillDictionary[kRPGSkillEffectRepresentationSkillDescription] copy];
      _imageName = [skillDictionary[kRPGSkillEffectRepresentationImageName] copy];
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
