//
//  RPGAuthorizationLogoutRequest.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBasicNetworkRequest.h"

static NSString * const kRPGBasicNetworkRequestToken = @"token";

@interface RPGBasicNetworkRequest ()

@property (nonatomic, copy, readwrite) NSString *token;

@end

@implementation RPGBasicNetworkRequest

@synthesize token = _token;

#pragma mark - Init

- (instancetype)initWithToken:(NSString *)aToken
{
  self = [super init];
  
  if (self != nil)
  {
    if (aToken == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _token = [aToken copy];
    }
  }
  
  return self;
}

+ (instancetype)requestWithToken:(NSString *)aToken
{
  return [[[self alloc] initWithToken:aToken] autorelease];
}

- (instancetype)init
{
  return [self initWithToken:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_token release];
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGBasicNetworkRequestToken] = self.token;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithToken:aDictionary[kRPGBasicNetworkRequestToken]];
}


@end
