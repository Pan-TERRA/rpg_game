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

- (instancetype)initWithToken:(NSString *)aToken characterID:(NSInteger)characterID
{
  self = [super init];
  if (self != nil)
  {
    if (aToken != nil && characterID >= 0)
    {
      _token = [aToken copy];
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

+ (instancetype)skillsRequestWithToken:(NSString *)aToken characterID:(NSInteger)aCharacterID
{
  return [[[self alloc] initWithToken:aToken characterID:aCharacterID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_token release];
  [super dealloc];
}



@end
