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
@property (readwrite, nonatomic) int status;

@end

@implementation RPGResponse

@synthesize type = _type;
@synthesize status = _status;

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType status:(int)aStatus
{
  self = [super init];
  
  if (aStatus == -1)
  {
    [self release];
    self = nil;
  }

  if (self != nil)
  {
    _type = [aType copy];
    _status = aStatus;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithType:nil status:-1];
}

+ (instancetype)requestWithType:(NSString *)aType status:(int)aStatus
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
