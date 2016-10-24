//
//  RPGSpellCondtion+Serialization.m
//  
//
//  Created by Иван Дзюбенко on 10/24/16.
//
//

#import "RPGSpellActionRequest+Serialization.h"
#import "RPGRequest+Serialization.h"

NSString * const kRPGSpellActionSpellID = @"spell_id";

@implementation RPGSpellActionRequest (Serialization)

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGSpellActionSpellID] = @(self.spellID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithSpellID:[aDictionary[kRPGSpellActionSpellID] integerValue]
                         token:aDictionary[kRPGRequestSerializationToken]];
}

@end
