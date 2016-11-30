//
//  RPGFriendAddRequest.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriendAddRequest.h"

NSString * const kRPGFriendAddRequestFriendID = @"friend_id";

@interface RPGFriendAddRequest()

@property (nonatomic, assign, readwrite) NSInteger friendID;

@end

@implementation RPGFriendAddRequest

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

+ (instancetype)addFriendRequestWithFriendID:(NSInteger)aFriendID
{
  return [[[self alloc] initWithFriendID:aFriendID] autorelease];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGFriendAddRequestFriendID] = @(self.friendID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithFriendID:[aDictionary[kRPGFriendAddRequestFriendID] integerValue]];
}

@end
