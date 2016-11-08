//
//  RPGResources.m
//  RPG Game
//
//  Created by Максим Шульга on 11/8/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResources.h"

@interface RPGResources()

@property (nonatomic, assign, readwrite) NSInteger gold;
@property (nonatomic, assign, readwrite) NSInteger crystals;

@end

@implementation RPGResources

#pragma mark - Init

- (instancetype)initWithGold:(NSInteger)aGold
                    crystals:(NSInteger)aCrystals
{
  self = [super init];
  
  if (self != nil)
  {
    _gold = aGold;
    _crystals = aCrystals;
  }
  
  return self;
}

+ (instancetype)resourcesWithGold:(NSInteger)aGold
                         crystals:(NSInteger)aCrystals
{
  return [[[self alloc] initWithGold:aGold crystals:aCrystals] autorelease];
}

- (instancetype)init
{
  return [self initWithGold:0 crystals:0];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

@end
