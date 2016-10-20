//
//  RPGResponse.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGResponse.h"

@interface RPGResponse ()

@property (nonatomic, copy, readwrite) NSString *type;
@property (nonatomic, assign, readwrite) NSInteger status;

@end

@implementation RPGResponse

#pragma mark - Init

- (instancetype)initWithType:(NSString *)aType
                      status:(NSInteger)aStatus
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

+ (instancetype)responseWithType:(NSString *)aType
                          status:(NSInteger)aStatus
{
  return [[[self alloc] initWithType:aType
                              status:aStatus] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_type release];
  [super dealloc];
}

@end