//
//  RPGQuestResponse.m
//  RPG Game
//
//  Created by Максим Шульга on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestResponse.h"

@interface RPGQuestResponse()

@property (nonatomic, assign, readwrite) NSInteger status;

@end

@implementation RPGQuestResponse

- (instancetype)initWithStatus:(NSInteger)aStatus
{
  self = [super init];
  
  if (self != nil)
  {
    _status = aStatus;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithStatus:-1];
}

+ (instancetype)questResponseWithStatus:(NSInteger)aStatus
{
  return [[[self alloc] initWithStatus:aStatus] autorelease];
}

@end
