//
//  RPGAuthorizationLoginRequest.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationLoginRequest.h"

@interface RPGAuthorizationLoginRequest ()

@property (copy, nonatomic, readwrite) NSString *email;
@property (copy, nonatomic, readwrite) NSString *password;

@end

@implementation RPGAuthorizationLoginRequest

@synthesize password = _password;
@synthesize email = _email;

#pragma mark - Init

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword
{
  self = [super init];
  
  if (self != nil)
  {
    _email = [anEmail copy];
    _password = [aPassword copy];
  }
  
  return self;
}

+ (instancetype)authorizationRequestWithEmail:(NSString *)anEmail
                                     password:(NSString *)aPassword
{
  return [[[self alloc] initWithEmail:anEmail password:aPassword] autorelease];
}

- (instancetype)init
{
  return nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_email release];
  [_password release];
  
  [super dealloc];
}



@end
