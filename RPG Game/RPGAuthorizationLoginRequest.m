//
//  RPGAuthorizationLoginRequest.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginRequest.h"

@interface RPGAuthorizationLoginRequest ()

@property (nonatomic, copy, readwrite) NSString *email;
@property (nonatomic, copy, readwrite) NSString *password;

@end

@implementation RPGAuthorizationLoginRequest

#pragma mark - Init

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword
{
  self = [super init];
  
  if (self != nil)
  {
    if (anEmail == nil || aPassword == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _email = [anEmail copy];
      _password = [aPassword copy];
    }
  }
  
  return self;
}

+ (instancetype)authorizationRequestWithEmail:(NSString *)anEmail
                                     password:(NSString *)aPassword
{
  return [[[self alloc] initWithEmail:anEmail
                             password:aPassword] autorelease];
}

- (instancetype)init
{
  return [self initWithEmail:nil
                    password:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_email release];
  [_password release];
  [super dealloc];
}

@end
