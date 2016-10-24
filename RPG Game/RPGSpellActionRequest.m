//
//  RPGSpellCondtion.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/24/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSpellActionRequest.h"

NSString * const kRPGSpellActionRequestType = @"SPELL_ACTION";

@implementation RPGSpellActionRequest

#pragma mark - Init

- (instancetype)initWithSpellID:(NSInteger)aSpellID token:(NSString *)aToken
{
  self = [super initWithType:kRPGSpellActionRequestType token:aToken];
  
  if (self != nil)
  {
    _spellID = aSpellID;
  }
  
  return self;
}

+ (instancetype)requestWithSpellID:(NSInteger)aSpellID token:(NSString *)aToken
{
  return [[[self alloc] initWithSpellID:aSpellID token:aToken] autorelease];
}

- (instancetype)initWithType:(NSString *)aType token:(NSString *)aToken
{
  return [self initWithSpellID:-1 token:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

@end
