//
//  RPGAuthorizationRequest.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/12/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAuthorizationRequest.h"

static NSString *const kRPGAuthorizationRequestType = @"USER_REQUEST";

@interface RPGAuthorizationRequest ()

@property (copy, nonatomic, readwrite) NSString *email;
@property (copy, nonatomic, readwrite) NSString *password;

@end

@implementation RPGAuthorizationRequest

@synthesize password = _password;
@synthesize email = _email;

#pragma mark - Init

- (instancetype)initWithEmail:(NSString *)anEmail
                     password:(NSString *)aPassword
{
  self = [super initWithType:kRPGAuthorizationRequestType token:@""];
  
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

#pragma mark - Dealloc

- (void)dealloc
{
  [_email release];
  [_password release];
  
  [super dealloc];
}



@end
