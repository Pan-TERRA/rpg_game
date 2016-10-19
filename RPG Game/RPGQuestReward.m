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
@property (nonatomic, assign, readwrite) NSUInteger skillId;

@end

@implementation RPGQuestReward

#pragma mark - Init

- (instancetype)initWithGold:(NSUInteger)gold
                    crystals:(NSUInteger)crystals
                     skillId:(NSUInteger)skillId
{
  self = [super init];
  
  if (self != nil)
  {
    _gold = gold;
    _crystals = crystals;
    _skillId = skillId;
  }
  
  return self;
}

+ (instancetype)responseWithGold:(NSUInteger)gold
                        crystals:(NSUInteger)crystals
                         skillId:(NSUInteger)skillId
{
  return [[[self alloc] initWithGold:gold crystals:crystals skillId:skillId] autorelease];
}

- (instancetype)init
{
  return [self initWithGold:0 crystals:0 skillId:0];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

@end