//
//  RPGFriendRequest.m
//  RPG Game
//
//  Created by Владислав Крут on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendRequest.h"

NSString * const kRPGFriendRequestFriendID = @"friend_id";

@interface RPGFriendRequest()

@property (nonatomic, assign, readwrite) NSInteger friendID;

@end

@implementation RPGFriendRequest

#pragma mark - Init

- (instancetype)initWithFriendID:(NSInteger)aFriendID
{
  self = [super init];
  
  if (self != nil)
  {
    _friendID = aFriendID;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithFriendID:-1];
}

+ (instancetype)friendRequestWithFriendID:(NSInteger)aFriendID
{
  return [[[self alloc] initWithFriendID:aFriendID] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGFriendRequestFriendID] = @(self.friendID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithFriendID:[aDictionary[kRPGFriendRequestFriendID] integerValue]];
}

@end
