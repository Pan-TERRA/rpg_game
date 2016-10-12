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

@end

@implementation RPGResponse

@synthesize type = _type;

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
  return nil;
}

+ (instancetype)requestWithType:(NSString *)aType
{
  return [[[RPGResponse alloc] initWithType:aType] autorelease];
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
