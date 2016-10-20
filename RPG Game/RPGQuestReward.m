//
//  RPGQuestReward.m
//  RPG Game
//
//  Created by Максим Шульга on 10/19/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestReward.h"

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

@end