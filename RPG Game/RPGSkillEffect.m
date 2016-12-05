//
//  RPGSkillEffect.m
//  RPG Game
//
//  Created by Максим Шульга on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillEffect.h"

static NSString * const kRPGSkillEffectID = @"effect_id";
static NSString * const kRPGSkillEffectDuration = @"duration";

@interface RPGSkillEffect ()

@property (nonatomic, assign, readwrite) NSInteger skillEffectID;
@property (nonatomic, assign, readwrite) NSInteger duration;

@end

@implementation RPGSkillEffect

#pragma mark - Init

- (instancetype)initWithSkillEffectID:(NSInteger)aSkillEffectID
                             duration:(NSInteger)aDuration
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
      _skillEffectID = aSkillEffectID;
      _duration = aDuration;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithSkillEffectID:-1
                            duration:-1];
}

+ (instancetype)skillEffectWithSkillEffectID:(NSInteger)aSkillEffectID
                                    duration:(NSInteger)aDuration
{
  return [[[self alloc] initWithSkillEffectID:aSkillEffectID
                                     duration:aDuration] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGSkillEffectID] = @(self.skillEffectID);
  dictionaryRepresentation[kRPGSkillEffectDuration] = @(self.duration);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithSkillEffectID:[aDictionary[kRPGSkillEffectID] integerValue]
                            duration:[aDictionary[kRPGSkillEffectDuration] integerValue]];
}

@end
