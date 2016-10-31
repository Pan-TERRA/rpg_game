//
//  RPGClassInfoResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGClassInfoResponse.h"

@implementation RPGClassInfoResponse

- (instancetype)initWithStatus:(NSInteger)status classInfo:(NSDictionary *)classInfo
{
  self = [super init];
  if (self != nil)
  {
    _status = status;
    _classInfo = [[NSDictionary alloc] initWithDictionary:classInfo];
  }
  return self;
}

- (void)dealloc
{
  [_classInfo release];
  [super dealloc];
}

@end
