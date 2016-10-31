//
//  RPGClassesResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGClassesResponse.h"

@implementation RPGClassesResponse

- (instancetype)init
{
  return [self initWithStatus:-1 classes:nil];
}

- (instancetype)initWithStatus:(NSInteger)status classes:(NSArray *)classes
{
  self = [super init];
  if (self != nil)
  {
    _status = status;
    if (classes != nil)
    {
    _classes = [[NSArray alloc] initWithArray:classes];
    }
    else
    {
      _classes = [[NSArray alloc] init];
    }
  }
  
  return self;
}

- (void)dealloc
{
  [_classes release];
  [super dealloc];
}

@end
