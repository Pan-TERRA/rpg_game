//
//  RPGQuestReward.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReward.h"

NSString * const kRPGQuestRewardGold = @"gold";
NSString * const kRPGQuestRewardCrystals = @"crystals";
NSString * const kRPGQuestRewardSkillId = @"skill_id";

@interface RPGQuestReward()

@property (nonatomic, assign, readwrite) NSUInteger skillID;

@end

@implementation RPGQuestReward

#pragma mark - Init

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
                     skillID:(NSUInteger)aSkillID
{
  self = [super initWithGold:aGold crystals:aCrystals];
  
  if (self != nil)
  {
    _skillID = aSkillID;
  }
  
  return self;
}

+ (instancetype)questRewardWithGold:(NSInteger)aGold
                           crystals:(NSInteger)aCrystals
                            skillID:(NSUInteger)aSkillID
{
  return [[[self alloc] initWithGold:aGold crystals:aCrystals skillID:aSkillID] autorelease];
}

- (instancetype)init
{
  return [self initWithGold:0 crystals:0 skillID:0];
}

- (instancetype)initWithGold:(NSInteger)aGold crystals:(NSInteger)aCrystals
{
  return [self initWithGold:0 crystals:0 skillID:0];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
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
