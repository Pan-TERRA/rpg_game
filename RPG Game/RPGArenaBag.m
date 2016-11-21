//
//  RPGArenaBag.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/20/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaBag.h"

const NSUInteger kRPGArenaBagSetSize = 3;

@interface RPGArenaBag ()

@property (nonatomic, retain, readwrite) NSMutableArray *bag;

@end

@implementation RPGArenaBag

- (instancetype)initWithArray:(NSArray *)anArray
{
  self = [super init];
  
  if (self != nil)
  {
    if (anArray != nil && (anArray.count % kRPGArenaBagSetSize) == 0)
    {
      _bag = [anArray mutableCopy];
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (NSArray *)getNextRandomItems
{
  NSArray *result = nil;
  NSIndexSet *randomIndices = [self getNextRandomItemIndices];
  
  if (randomIndices.count != 0)
  {
    result = [self.bag objectsAtIndexes:randomIndices];
    [self.bag removeObjectsAtIndexes:randomIndices];
  }
  
  return result;
}

- (NSIndexSet *)getNextRandomItemIndices
{
  NSMutableIndexSet *result = [NSMutableIndexSet indexSet];
  NSUInteger bagCount = self.bag.count;
  
  for (int i = 0; i < kRPGArenaBagSetSize; i++)
  {
    NSUInteger randomIndex = 0;
    do
    {
      randomIndex = arc4random() % bagCount;
    }
    while ([result containsIndex:randomIndex]);
    [result addIndex:randomIndex];
  }
  
  return result;
}

@end
