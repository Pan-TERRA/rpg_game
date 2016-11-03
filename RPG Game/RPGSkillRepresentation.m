//
//  RPGSkillRepresentation.m
//  RPG Game
//
//  Created by Владислав Крут on 11/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillRepresentation.h"

NSString * const kRPGSkillRepresentationName = @"name";
NSString * const kRPGSkillRepresentationSpecification = @"description";
NSString * const kRPGSkillRepresentationMultiplier = @"multiplier";
NSString * const kRPGSkillRepresentationCooldown = @"cooldown";
NSString * const kRPGSkillRepresentationImageName = @"imageName";
NSString * const kRPGSkillRepresentationSoundName = @"soundName";

@implementation RPGSkillRepresentation


#pragma mark - Init/Dealloc
- (instancetype)initWithSkillID:(NSInteger)aSkillID
{
  self = [super init];
  if (self)
  {
    //TODO: remove hardcode
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RPGSkillsInfo" ofType:@"plist"];
    NSDictionary *plistDictionary = [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];
    NSDictionary *skillDictionary = [plistDictionary valueForKey:[@(aSkillID) stringValue]];
    
    _name = [skillDictionary[kRPGSkillRepresentationName] copy];
    _specification = [skillDictionary[kRPGSkillRepresentationSpecification] copy];
    _multiplier = [skillDictionary[kRPGSkillRepresentationMultiplier] floatValue];
    _cooldown = [skillDictionary[kRPGSkillRepresentationCooldown] integerValue];
    _imageName = [skillDictionary[kRPGSkillRepresentationImageName] copy];
    _soundName = [skillDictionary[kRPGSkillRepresentationSoundName] copy];
  }
  return self;
}

- (void)dealloc
{
  [_name release];
  [_specification release];
  [_imageName release];
  [_soundName release];
  [super dealloc];
}

@end
