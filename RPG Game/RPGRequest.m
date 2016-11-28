//
//  RPGRequest.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"

NSString *const kRPGRequestSerializationType = @"type";

@interface RPGRequest ()

@property (nonatomic, copy, readwrite) NSString *type;

@end

@implementation RPGRequest

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
{
  self = [super init];
  
  if (self != nil)
  {
    _type = [aType copy];
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithType:nil];
}

+ (instancetype)requestWithType:(NSString *)aType
{
  return [[[self alloc] initWithType:aType] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_type release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGRequestSerializationType] = self.type;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithType:aDictionary[kRPGRequestSerializationType]];
}

@end
