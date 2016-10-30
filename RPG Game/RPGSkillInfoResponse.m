//
//  RPGSkillInfoResponse.m
//  RPG Game
//
//  Created by Степан Супинский on 10/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillInfoResponse.h"

@implementation RPGSkillInfoResponse

- (instancetype)initWithStatus:(NSInteger)status skill:(NSDictionary *)skill
{
  self = [super init];
  if (self)
  {
    if (status >= 0 && skill != nil)
    {
      _status = status;
      _skill = [[NSDictionary alloc] initWithDictionary:skill];
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  return self;
}

- (void)dealloc
{
  [_skill release];
  [super dealloc];
}

@end
