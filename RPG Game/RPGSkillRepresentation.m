//
//  RPGSkillRepresentation.m
//  RPG Game
//
//  Created by Владислав Крут on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillRepresentation.h"

NSString * const kRPGSkillRepresentationName = @"name";
NSString * const kRPGSkillRepresentationSkillDescription = @"description";
NSString * const kRPGSkillRepresentationMultiplier = @"multiplier";
NSString * const kRPGSkillRepresentationAbsoluteCooldown = @"cooldown";
NSString * const kRPGSkillRepresentationImageName = @"imageName";
NSString * const kRPGSkillRepresentationSoundName = @"soundName";

@implementation RPGSkillRepresentation


#pragma mark - Init/Dealloc
- (instancetype)initWithSkillID:(NSInteger)aSkillID
{
  self = [super init];
  
  if (self != nil)
  {
    //TODO: remove hardcode
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RPGSkillsInfo" ofType:@"plist"];
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *skillDictionary = [plistDictionary valueForKey:[@(aSkillID) stringValue]];
    
    _name = [skillDictionary[kRPGSkillRepresentationName] copy];
    _skillDescription = [skillDictionary[kRPGSkillRepresentationSkillDescription] copy];
    _multiplier = [skillDictionary[kRPGSkillRepresentationMultiplier] floatValue];
    _absoluteCooldown = [skillDictionary[kRPGSkillRepresentationAbsoluteCooldown] integerValue];
    _remainingCooldown = 0;
    _imageName = [skillDictionary[kRPGSkillRepresentationImageName] copy];
    _soundName = [skillDictionary[kRPGSkillRepresentationSoundName] copy];
  }
  
  return self;
}

+ (instancetype)skillrepresentationWithSkillID:(NSInteger)aSkillID
{
  return [[[self alloc] initWithSkillID:aSkillID] autorelease];
}

- (void)dealloc
{
  [_name release];
  [_skillDescription release];
  [_imageName release];
  [_soundName release];
  [super dealloc];
}

@end
