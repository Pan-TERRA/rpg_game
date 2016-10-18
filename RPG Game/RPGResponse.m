//
//  RPGResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@interface RPGResponse ()

@property (copy, readwrite, nonatomic) NSString *type;
@property (readwrite, nonatomic) NSInteger status;

@end

@implementation RPGResponse

@synthesize type = _type;
@synthesize status = _status;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType status:(NSInteger)aStatus
{
  self = [super init];
  
 

  if (self != nil)
  {
    if (aType == nil)
    {
      [self release];
      self = nil;
    }
    else
    {
      _type = [aType copy];
      _status = aStatus;      
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithType:nil status:-1];
}

+ (instancetype)requestWithType:(NSString *)aType status:(NSInteger)aStatus
{
  return [[[self alloc] initWithType:aType status:aStatus] autorelease];
}

+ (instancetype)request
{
  return nil;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_type release];
  
  [super dealloc];
}

@end
