//
//  RPGPlayer.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer.h"

@implementation RPGPlayer

@synthesize spells = _spells;

#pragma mark - Init

- (instancetype)initWithSpells:(NSArray *)aSpells
{
  self = [super init];
  
  if (self != nil)
  {
    _spells = aSpells;
  }
  
  return self;
}

+ (instancetype)playerWithSpells:(NSArray *)aSpells
{
  return [[self alloc] initWithSpells:aSpells];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_spells release];
  
  [super dealloc];
}
@end
