//
//  RPGNetworkManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"
#import "RPGAuthorizationRequest+Serialization.h"

static RPGNetworkManager *sharedNetworkManager = nil;

@interface RPGNetworkManager ()

@property (copy, nonatomic) NSString *token;

@end

@implementation RPGNetworkManager

#pragma mark - Init


- (id)init
{
  self = [super init];
  
  if (self != nil)
  {
  
    
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

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - Authorization API

- (void)login
{
  
}

- (void)loginWithRequest:(RPGAuthorizationRequest *)aRequest
{
 
}

- (void)logout
{
  
}

- (void)registration
{
  
}

#pragma mark - Authorization API

- (void)fetchQuestByType:(int)aType {
	
}





@end