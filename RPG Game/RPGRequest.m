//
//  RPGRequest.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGRequest.h"

@interface RPGRequest ()

@property (copy, readwrite, nonatomic) NSString *type;
@property (copy, readwrite, nonatomic) NSString *token;

@end

@implementation RPGRequest

@synthesize type = _type;
@synthesize token = _token;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType token:(NSString *)aToken
{
  self = [super init];
  
  if (self != nil)
  {
    _type = [aType copy];
    _token = [aToken copy];
  }
  
  return self;
}

- (instancetype)init
{
  return nil;
}

+ (instancetype)requestWithType:(NSString *)aType token:(NSString *)aToken
{
  return [[[RPGRequest alloc] initWithType:aType token:aToken] autorelease];
}

+ (instancetype)request
{
  return nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_type release];
  [_token release];
  
  [super dealloc];
}

@end
