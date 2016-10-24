//
//  RPGSpell.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSpell.h"

@interface RPGSpell ()

@property (assign, nonatomic, readwrite) NSInteger spellID;

@end

@implementation RPGSpell

#pragma mark - Init

- (instancetype)initWithSpellID:(NSInteger)aSpellID cooldown:(NSInteger)aCooldown
{
  self = [super init];
  
  if (self != nil)
  {
    _spellID = aSpellID;
    _cooldown = aCooldown;
  }
  
  return self;
}

+ (instancetype)spellWithSpellID:(NSInteger)aSpellID cooldown:(NSInteger)aCooldown
{
  return [[[self alloc] initWithSpellID:aSpellID cooldown:aCooldown] autorelease];
}


@end
