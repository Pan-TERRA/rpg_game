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

@property (nonatomic, retain, readwrite) NSArray *friends;

@end

@implementation RPGFriendListResponse

#pragma mark - Init

- (instancetype)initWithStatus:(RPGStatusCode)aStatus
                        friends:(NSArray *)aFriends
{
  self = [super initWithStatus:aStatus];
  
  if (self != nil)
  {
    if (aStatus == kRPGStatusCodeOK && aFriends == nil)
    {
      [self release];
      self = nil;
    }
    else if (aStatus != kRPGStatusCodeOK && aFriends == nil)
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
                            friends:(NSArray *)aFriends
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
    NSMutableArray *friendsMutableArray = [NSMutableArray array];
    for (RPGFriend *aFriend in self.friends)
    {
      [friendsMutableArray addObject:[aFriend dictionaryRepresentation]];
    }
    
    dictionaryRepresentation[kRPGFriendsListResponseFriends] = friendsMutableArray;
  }
  return [dictionaryRepresentation autorelease];
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSInteger status = [aDictionary[kRPGBasicNetworkResponseStatus] integerValue];
  
  NSArray *friendsDictionaryArray = aDictionary[kRPGFriendsListResponseFriends];
  
  NSMutableArray *friends  =[NSMutableArray array];
  
  for (NSDictionary *friendDictionary in friendsDictionaryArray)
  {
    RPGFriend *aFriend = [[[RPGFriend alloc] initWithDictionaryRepresentation:friendDictionary] autorelease];
    [friends addObject:aFriend];
  }
  
  return [self initWithStatus:status friends:friends];
}

@end
