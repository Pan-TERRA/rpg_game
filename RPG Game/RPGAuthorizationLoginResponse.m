//
//  RPGAuthorizationLoginResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginResponse.h"

@interface RPGAuthorizationLoginResponse ()

@property (copy, nonatomic, readwrite) NSString *username;
@property (copy, nonatomic, readwrite) NSString *token;
@property (copy, nonatomic, readwrite) NSString *avatar;

@property (nonatomic, readwrite) NSInteger gold;
@property (nonatomic, readwrite) NSInteger crystals;

@property (copy, nonatomic, readwrite) NSDictionary *characters;

@end

@implementation RPGAuthorizationLoginResponse

@synthesize username = _username;
@synthesize token = _token;
@synthesize avatar = _avatar;

@synthesize gold = _gold;
@synthesize crystals = _crystals;

@synthesize characters = characters;

#pragma mark - Init

- (instancetype)initWithToken:(NSString *)aToken
{
  self = [super init];
  
  if (self != nil)
  {
    _token = [aToken copy];
  }
  
  return self;
}

+ (instancetype)requestWithToken:(NSString *)aToken
{
  return [[[self alloc] initWithToken:aToken] autorelease];
}

- (instancetype)init
{
  return nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_token release];
  
  [super dealloc];
}


@end
