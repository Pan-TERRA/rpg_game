  //
  //  RPGEntity.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/24/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGEntity.h"

NSString * const kRPGEntityName = @"name";
NSString * const kRPGEntityHP = @"current_hp";
NSString * const kRPGEntityMaxHP = @"max_hp";

@implementation RPGEntity

#pragma mark - Init

- (instancetype)initWithName:(NSString *)aName HP:(NSInteger)aHP maxHP:(NSInteger)aMaxHP
{
  self = [super init];
  
  if (self != nil)
  {
    _name = [aName copy];
    _HP = aHP;
    _maxHP = aMaxHP;
  }
  
  return self;
}

+ (instancetype)entityWithName:(NSString *)aName HP:(NSInteger)aHP maxHP:(NSInteger)aMaxHP
{
  return [[[self alloc] initWithName:aName HP:aHP maxHP:aMaxHP] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_name release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGEntityName] = self.name;
  dictionaryRepresentation[kRPGEntityHP] = @(self.HP);
  dictionaryRepresentation[kRPGEntityMaxHP] = @(self.maxHP);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithName:aDictionary[kRPGEntityName]
                         HP:[aDictionary[kRPGEntityHP] integerValue]
                      maxHP:[aDictionary[kRPGEntityMaxHP] integerValue]];
}

@end
