//
//  RPGQuestReward.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReward.h"

static NSString * const kRPGQuestRewardSkillId = @"skill_id";

@interface RPGQuestReward()

@property (nonatomic, assign, readwrite) NSInteger skillID;

@end

@implementation RPGQuestReward

#pragma mark - Init

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
                     skillID:(NSInteger)aSkillID
{
  self = [super initWithGold:aGold crystals:aCrystals];
  
  if (self != nil)
  {
    if (aSkillID < 0)
    {
      [self release];
      self = nil;
    }
    else
    {
      _skillID = aSkillID;
    }
  }
  
  return self;
}

+ (instancetype)questRewardWithGold:(NSInteger)aGold
                           crystals:(NSInteger)aCrystals
                            skillID:(NSInteger)aSkillID
{
  return [[[self alloc] initWithGold:aGold
                            crystals:aCrystals
                             skillID:aSkillID] autorelease];
}

- (instancetype)init
{
  return [self initWithGold:-1
                   crystals:-1
                    skillID:-1];
}

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
{
  return [self initWithGold:-1
                   crystals:-1
                    skillID:-1];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGQuestRewardSkillId] = @(self.skillID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithGold:[aDictionary[kRPGResourcesGold] integerValue]
                   crystals:[aDictionary[kRPGResourcesCrystals] integerValue]
                    skillID:[aDictionary[kRPGQuestRewardSkillId] integerValue]];
}

@end
