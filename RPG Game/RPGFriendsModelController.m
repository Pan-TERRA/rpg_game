//
//  RPGFriendsModelController.m
//  RPG Game
//
//  Created by Владислав Крут on 12/7/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendsModelController.h"
  //Entity
#import "RPGFriend.h"

@interface RPGFriendsModelController ()

@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *allFriendsMutable;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *onlineFriendsMutable;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *incomingRequestsMutable;
@property (nonatomic, retain, readwrite) NSMutableArray<RPGFriend *> *outgoingRequestsMutable;

@end

@implementation RPGFriendsModelController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
    _allFriendsMutable = [NSMutableArray new];
    _onlineFriendsMutable = [NSMutableArray new];
    _incomingRequestsMutable = [NSMutableArray new];
    _outgoingRequestsMutable = [NSMutableArray new];
  }
  
  return self;
}

- (instancetype)initWithFriends:(NSArray<RPGFriend *> *)aFriends
{
  self = [self init];
  
  if (self != nil)
  {
    [self setData:aFriends];
  }
  
  return self;
}

+ (instancetype)modelControllerWithFriends:(NSArray<RPGFriend *> *)aFriends
{
  return [[[self alloc] initWithFriends:aFriends] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_allFriendsMutable release];
  [_onlineFriendsMutable release];
  [_incomingRequestsMutable release];
  [_outgoingRequestsMutable release];
  
  [super dealloc];
}

#pragma mark - API

- (void)setData:(NSArray<RPGFriend *> *)aFriends
{
  for (RPGFriend *friend in aFriends)
  {
    switch (friend.state)
    {
      case kRPGFriendStateAccept:
      {
        if (friend.isOnline)
        {
          [self.onlineFriendsMutable addObject:friend];
        }
        
        break;
      }
        
      case kRPGFriendStateIncoming:
      {
        [self.incomingRequestsMutable addObject:friend];
        
        break;
      }
        
      case kRPGFriendStateOutgoing:
      {
        [self.outgoingRequestsMutable addObject:friend];
        
        break;
      }
        
      default:
      {
        break;
      }
    }
    [self.allFriendsMutable addObject:friend];
  }
  
  [self sortAllFriendsMutableArray];
}

#pragma mark - Getters

- (NSArray<RPGFriend *> *)allFriends
{
  return self.allFriendsMutable;
}

- (NSArray<RPGFriend *> *)onlineFriends
{
  return self.onlineFriendsMutable;
}

- (NSArray<RPGFriend *> *)incomingRequests
{
  return self.incomingRequestsMutable;
}

- (NSArray<RPGFriend *> *)outgoingRequests
{
  return self.outgoingRequestsMutable;
}

#pragma mark - Helper Methods

- (void)sortAllFriendsMutableArray
{
  NSArray *sortedArray = [self.allFriendsMutable sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
      NSNumber *first = @(((RPGFriend *)obj1).state);
      NSNumber *second = @(((RPGFriend *)obj2).state);
      NSComparisonResult result = [first compare:second];
      
      //if state is equal - check for online
      if (result == NSOrderedSame)
      {
        first = @(((RPGFriend *)obj1).online);
        second = @(((RPGFriend *)obj2).online);
        result = [second compare:first];
      }
      
      return result;
    }];
  
  self.allFriendsMutable = [NSMutableArray arrayWithArray:sortedArray];
}

@end
