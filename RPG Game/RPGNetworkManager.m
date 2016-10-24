//
//  RPGNetworkManager.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGNetworkManager.h"

static RPGNetworkManager *sharedNetworkManager = nil;

#pragma mark - API constants

// General
NSString * const kRPGNetworkManagerAPIHost = @"http://10.55.33.28:8000";
// Authorization
NSString * const kRPGNetworkManagerAPILoginRoute = @"/login";
NSString * const kRPGNetworkManagerAPISignoutRoute = @"/signout";
// Registration
NSString * const kRPGNetworkManagerAPIRegisterRoute = @"/register";
// Quests
NSString * const kRPGNetworkManagerAPIQuestsRoute = @"/quests";
NSString * const kRPGNetworkManagerAPIQuestsInProgressRoute = @"/in_progress_quests";
NSString * const kRPGNetworkManagerAPIConfirmedQuestsRoute = @"/confirmed_quests";
NSString * const kRPGNetworkManagerAPIReviewQuestsRoute = @"/review_quests";
NSString * const kRPGNetworkManagerAPIAcceptQuestRoute = @"/accept_quest";

#pragma mark -

@implementation RPGNetworkManager

#pragma mark - Init

- (id)init
{
  return [super init];
}

+ (id)sharedNetworkManager
{
  @synchronized (self)
  {
    if (sharedNetworkManager == nil)
    {
      sharedNetworkManager = [[super allocWithZone:NULL] init];
    }
  }
  
  return sharedNetworkManager;
}

#pragma mark - Singleton

+ (id)allocWithZone:(NSZone *)aZone
{
  return [[self sharedNetworkManager] retain];
}

- (id)copyWithZone:(NSZone *)aZone
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
