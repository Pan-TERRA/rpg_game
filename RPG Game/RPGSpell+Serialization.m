//
//  RPGSpell+Serialization.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSpell+Serialization.h"

NSString * const kRPGSpellID = @"spell_id";
NSString * const kRPGSpellCooldown = @"cooldown";

@implementation RPGSpell (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGSpellID] = @(self.spellID);
  dictionaryRepresentation[kRPGSpellCooldown] = @(self.cooldown);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithSpellID:[aDictionary[kRPGSpellID] integerValue]
                      cooldown:[aDictionary[kRPGSpellCooldown] integerValue]];
}


@end
