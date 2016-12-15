//
//  RPGDuelQuestRequest.m
//  RPG Game
//
//  Created by Максим Шульга on 12/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGDuelQuestRequest.h"

NSString * const kRPGDuelQuestRequestFriendID = @"friend_id";

@interface RPGDuelQuestRequest()

@property (nonatomic, assign, readwrite) NSInteger friendID;

@end

@implementation RPGDuelQuestRequest

#pragma mark - Init

- (instancetype)initWithQuestID:(NSInteger)aQuestID
                       friendID:(NSInteger)aFriendID
{
  self = [super initWithQuestID:aQuestID];
  
  if (self != nil)
  {
    if (aFriendID < 1)
    {
      [self release];
      self = nil;
    }
    else
    {
      _friendID = aFriendID;
    }
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithQuestID:-1
                      friendID:-1];
}

- (instancetype)initWithQuestID:(NSInteger)aQuestID
{
  return [self initWithQuestID:aQuestID
                      friendID:-1];
}

+ (instancetype)duelQuestRequestWithQuestID:(NSInteger)aQuestID
                                   friendID:(NSInteger)aFriendID
{
  return [[[self alloc] initWithQuestID:aQuestID
                               friendID:aFriendID] autorelease];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [[[super dictionaryRepresentation] mutableCopy] autorelease];
  
  dictionaryRepresentation[kRPGDuelQuestRequestFriendID] = @(self.friendID);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithQuestID:[aDictionary[kRPGQuestRequestQuestID] integerValue]
                      friendID:[aDictionary[kRPGDuelQuestRequestFriendID] integerValue]];
}

@end
