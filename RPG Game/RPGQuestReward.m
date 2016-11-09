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

@property (nonatomic, assign, readwrite) NSUInteger gold;
@property (nonatomic, assign, readwrite) NSUInteger crystals;
@property (nonatomic, assign, readwrite) NSUInteger skillID;

@end

@implementation RPGQuestReward

#pragma mark - Init

- (instancetype)initWithGold:(NSUInteger)aGold
                    crystals:(NSUInteger)aCrystals
                     skillID:(NSUInteger)aSkillID
{
  self = [super init];
  
  if (self != nil)
  {
    _gold = aGold;
    _crystals = aCrystals;
    _skillID = aSkillID;
  }
  
  return self;
}

+ (instancetype)questRewardWithGold:(NSUInteger)aGold
                           crystals:(NSUInteger)aCrystals
                            skillID:(NSUInteger)aSkillID
{
  return [[[self alloc] initWithGold:aGold crystals:aCrystals skillID:aSkillID] autorelease];
}

- (instancetype)init
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
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGQuestRewardGold] = @(self.gold);
  dictionaryRepresentation[kRPGQuestRewardCrystals] = @(self.crystals);
  dictionaryRepresentation[kRPGQuestRewardSkillId] = @(self.skillID);
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSUInteger gold = [aDictionary[kRPGQuestRewardGold] integerValue];
  NSUInteger crystals = [aDictionary[kRPGQuestRewardCrystals] integerValue];
  NSUInteger skillID = [aDictionary[kRPGQuestRewardSkillId] integerValue];
  
  return [self initWithGold:gold crystals:crystals skillID:skillID];
}

@end