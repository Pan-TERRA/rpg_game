//
//  RPGQuestChallengeRequest.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestChallengeRequest.h"

NSString * const kRPGQuestChallengeRequestFriendID = @"friend_id";

@interface RPGQuestChallengeRequest()

@property (nonatomic, assign, readwrite) NSInteger friendID;

@end

@implementation RPGQuestChallengeRequest

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

+ (instancetype)questChallengeRequestWithFriendID:(NSInteger)aFriendID
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
  
  dictionaryRepresentation[kRPGQuestChallengeRequestFriendID] = @(self.friendID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithFriendID:[aDictionary[kRPGQuestChallengeRequestFriendID] integerValue]];
}


@end
