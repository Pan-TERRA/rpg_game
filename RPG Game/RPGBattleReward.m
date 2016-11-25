//
//  RPGBattleReward.m
//  RPG Game
//
//  Created by Максим Шульга on 11/25/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleReward.h"

static NSString * const kRPGBattleRewardExp = @"exp";

@interface RPGBattleReward()

@property (nonatomic, assign, readwrite) NSUInteger exp;

@end

@implementation RPGBattleReward

#pragma mark - Init

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
                         exp:(NSUInteger)anExp
{
  self = [super initWithGold:aGold crystals:aCrystals];
  
  if (self != nil)
  {
    _exp = anExp;
  }
  
  return self;
}

+ (instancetype)battleRewardWithGold:(NSInteger)aGold
                            crystals:(NSInteger)aCrystals
                                 exp:(NSUInteger)anExp
{
  return [[[self alloc] initWithGold:aGold crystals:aCrystals exp:anExp] autorelease];
}

- (instancetype)init
{
  return [self initWithGold:0 crystals:0 exp:0];
}

- (instancetype)initWithGold:(NSInteger)aGold crystals:(NSInteger)aCrystals
{
  return [self initWithGold:0 crystals:0 exp:0];
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
  
  dictionaryRepresentation[kRPGBattleRewardExp] = @(self.exp);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithGold:[aDictionary[kRPGResourcesGold] integerValue]
                   crystals:[aDictionary[kRPGResourcesCrystals] integerValue]
                        exp:[aDictionary[kRPGBattleRewardExp] integerValue]];
}

@end
