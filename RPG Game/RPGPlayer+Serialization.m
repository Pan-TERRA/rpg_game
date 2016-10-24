//
//  RPGPlayer+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGPlayer+Serialization.h"
#import "RPGEntity+Serialization.h"
#import "RPGSpell+Serialization.h"

NSString * const kRPGPlayerSpells = @"spells";

@implementation RPGPlayer (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  NSMutableArray *spells = [NSMutableArray arrayWithCapacity:[self.spells count]];
  for (RPGSpell *spell in self.spells)
  {
    [spells addObject:[spell dictionaryRepresentation]];
  }
  dictionaryRepresentation[kRPGEntityName] = spells;
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSMutableArray *spells = [NSMutableArray array];
  
  for (NSDictionary *spellDictionaryRepresentation in aDictionary[kRPGPlayerSpells])
  {
    [spells addObject:[[RPGSpell alloc] initWithDictionaryRepresentation:spellDictionaryRepresentation]];
  }
  
  return [self initWithSpells:[spells copy]];
}


@end
