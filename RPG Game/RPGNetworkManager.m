//
//  RPGNetworkManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

static RPGNetworkManager *sharedNetworkManager = nil;

@interface RPGNetworkManager ()

@property (copy, nonatomic, readwrite) NSString *token;

@end

@implementation RPGNetworkManager

#pragma mark - Init

- (id)init
{
  self = [super init];
  
  if (self != nil)
  {
    _token = [[NSString alloc] init];
  }
  
  return self;
}

+ (id)sharedNetworkManager
{
  @synchronized(self)
  {
    if(sharedNetworkManager == nil)
    {
      sharedNetworkManager = [[super allocWithZone:NULL] init];
    }
  }
  
  return sharedNetworkManager;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - Singleton

+ (id)allocWithZone:(NSZone *)zone
{
  return [[self sharedNetworkManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

- (id)retain
{
  return self;
}

- (NSUInteger)retainCount
{
  return UINT_MAX;
}

- (oneway void)release
{
  
}

- (id)autorelease
{
  return self;
}

@end