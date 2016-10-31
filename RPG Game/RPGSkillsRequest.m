//
//  RPGSkillsRequest.m
//  RPG Game
//
//  Created by Степан Супинский on 10/28/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsRequest.h"


@implementation RPGSkillsRequest

#pragma mark - Init

- (instancetype)initWithToken:(NSString *)token characterID:(NSInteger)characterID
{
  self = [super init];
  if (self != nil)
  {
    if (token != nil && characterID >= 0)
    {
      _token = [token copy];
      _characterID = characterID;
    }
    else
    {
      [self release];
      self = nil;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithToken:nil characterID:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_token release];
  [super dealloc];
}

@end
