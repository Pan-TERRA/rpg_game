//
//  RPGEntity.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGEntity.h"

@implementation RPGEntity

#pragma mark - Init

- (instancetype)initWithName:(NSString *)aName HP:(NSInteger)aHP
{
  self = [super init];
  
  if (self != nil)
  {
    _name = [aName copy];
    _HP = aHP;
  }
  
  return self;
}

+ (instancetype)entityWithName:(NSString *)aName HP:(NSInteger)aHP
{
  return [[[self alloc] initWithName:aName HP:aHP] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_name release];
  
  [super dealloc];
}

@end
