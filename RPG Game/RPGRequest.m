//
//  RPGRequest.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"

NSString *const kRPGRequestSerializationType = @"type";
NSString *const kRPGRequestSerializationToken = @"token";

@interface RPGRequest ()

@property (nonatomic, copy, readwrite) NSString *type;
@property (nonatomic, copy, readwrite) NSString *token;

@end

@implementation RPGRequest

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                       token:(NSString *)aToken
{
  self = [super init];
  
  if (self != nil)
  {
    if (aType == nil || aToken == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _type = [aType copy];
      _token = [aToken copy];
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithType:nil token:nil];
}

+ (instancetype)requestWithType:(NSString *)aType
                          token:(NSString *)aToken
{
  return [[[self alloc] initWithType:aType
                               token:aToken] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_type release];
  [_token release];
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGRequestSerializationType] = self.type;
  dictionaryRepresentation[kRPGRequestSerializationToken] = self.token;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithType:aDictionary[kRPGRequestSerializationType]
                      token:aDictionary[kRPGRequestSerializationToken]];
}

@end
