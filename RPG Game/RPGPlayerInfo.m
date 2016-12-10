//
//  RPGPlayerInfo.m
//  RPG Game
//
//  Created by Максим Шульга on 12/5/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayerInfo.h"
  // Entities
#import "RPGSkillEffect.h"

static NSString * const kRPGPlayerInfoHP = @"current_hp";
static NSString * const kRPGPlayerInfoEffects = @"effects";

@interface RPGPlayerInfo ()

@property (nonatomic, assign, readwrite) NSInteger HP;
@property (nonatomic, assign, readwrite) NSArray<RPGSkillEffect *> *skillsEffects;

@end

@implementation RPGPlayerInfo

- (instancetype)initWithHP:(NSInteger)aHP
             skillsEffects:(NSArray<RPGSkillEffect *> *)aSkillsEffects
{
  self = [super init];
  
  if (self != nil)
  {
    if (aHP < 0)
    {
      [self release];
      self = nil;
    }
    else
    {
      _HP = aHP;
      _skillsEffects = [aSkillsEffects copy];
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithHP:0
            skillsEffects:nil];
}

+ (instancetype)playerInfoWithHP:(NSInteger)aHP
                   skillsEffects:(NSArray<RPGSkillEffect *> *)aSkillsEffects
{
  return [[[self alloc] initWithHP:aHP
                     skillsEffects:aSkillsEffects] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGPlayerInfoHP] = @(self.HP);
  
  if (self.skillsEffects)
  {
    NSMutableArray *skillsEffectsMutableArray = [NSMutableArray array];
    for (RPGSkillEffect *skillEffect in self.skillsEffects)
    {
      [skillsEffectsMutableArray addObject:[skillEffect dictionaryRepresentation]];
    }
    dictionaryRepresentation[kRPGPlayerInfoEffects] = skillsEffectsMutableArray;
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSArray *skillsEffectsArray = aDictionary[kRPGPlayerInfoEffects];
  NSMutableArray *skillsEffects =[NSMutableArray array];
  
  for (NSDictionary *skillEffectDictionary in skillsEffectsArray)
  {
    RPGSkillEffect *skillEffect = [[[RPGSkillEffect alloc] initWithDictionaryRepresentation:skillEffectDictionary] autorelease];
    [skillsEffects addObject:skillEffect];
  }
  
  return [self initWithHP:[aDictionary[kRPGPlayerInfoHP] integerValue]
            skillsEffects:skillsEffects];
}

@end
