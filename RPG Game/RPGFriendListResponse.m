//
//  RPGFriendListResponse.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendListResponse.h"
  // Entity
#import "RPGFriend.h"

NSString * const kRPGFriendsListResponseFriends = @"friends";

@interface RPGFriendListResponse ()

@property (nonatomic, retain, readwrite) NSArray<NSDictionary *> *friends;

@end

@implementation RPGFriendListResponse

#pragma mark - Init

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                        friends:(NSArray<NSDictionary *> *)aFriends
{
  self = [super initWithStatus:aStatus];
  
  if (self != nil)
  {
    if (aStatus == kRPGStatusCodeOK && aFriends == nil)
    {
      [self release];
      self = nil;
    }
    else if (aFriends == nil)
    {
      _friends = nil;
    }
    else
    {
      _friends = [aFriends retain];
    }
  }
  
  return self;
}

+ (instancetype)responseWithStatus:(RPGStatusCode)aStatus
                            friends:(NSArray<NSDictionary *> *)aFriends
{
  return [[[self alloc] initWithStatus:aStatus
                                friends:aFriends] autorelease];
}

- (instancetype)init
{
  return [self initWithStatus:kRPGStatusCodeDefaultError
                       friends:nil];
}

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
{
  return [self initWithStatus:kRPGStatusCodeDefaultError friends:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_friends release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[super dictionaryRepresentation] mutableCopy];
  
  if (self.friends)
  {
    dictionaryRepresentation[kRPGFriendsListResponseFriends] = self.friends;
  }
  
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithStatus:[aDictionary[kRPGBasicNetworkResponseStatus] integerValue]
                      friends:aDictionary[kRPGFriendsListResponseFriends]];
}

@end
