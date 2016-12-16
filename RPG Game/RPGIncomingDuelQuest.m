//
//  RPGIncomingDuelQuest.m
//  RPG Game
//
//  Created by Максим Шульга on 12/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGIncomingDuelQuest.h"

static NSString * const kRPGIncomingDuelQuestQuestID = @"quest_id";
static NSString * const kRPGIncomingDuelQuestFriendID = @"friend_id";
static NSString * const kRPGIncomingDuelQuestFriendUsername = @"username";

@interface RPGIncomingDuelQuest()

@property (nonatomic, assign, readwrite) NSInteger questID;
@property (nonatomic, assign, readwrite) NSInteger friendID;
@property (nonatomic, copy, readwrite) NSString *friendUsername;

@end

@implementation RPGIncomingDuelQuest

#pragma mark - Init

- (instancetype)initWithQuestID:(NSInteger)aQuestID
                       friendID:(NSInteger)aFriendID
                 friendUsername:(NSString *)aFriendUsername
{
  self = [super init];
  
  if (self != nil)
  {
    if (aQuestID < 1 || aFriendID < 1)
    {
      [self release];
      self = nil;
    }
    else
    {
      _questID = aQuestID;
      _friendID = aFriendID;
      _friendUsername = [aFriendUsername copy];
    }
  }
  
  return self;
}

+ (instancetype)incomingDuelQuestWithQuestID:(NSInteger)aQuestID
                                    friendID:(NSInteger)aFriendID
                              friendUsername:(NSString *)aFriendUsername
{
  return [[[self alloc] initWithQuestID:aQuestID
                               friendID:aFriendID
                         friendUsername:aFriendUsername] autorelease];
}

- (instancetype)init
{
  return [self initWithQuestID:-1
                      friendID:-1
                friendUsername:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_friendUsername release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  
  dictionaryRepresentation[kRPGIncomingDuelQuestQuestID] = @(self.questID);
  dictionaryRepresentation[kRPGIncomingDuelQuestFriendID] = @(self.friendID);
  if (self.friendUsername != nil)
  {
    dictionaryRepresentation[kRPGIncomingDuelQuestFriendUsername] = self.friendUsername;
  }
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  return [self initWithQuestID:[aDictionary[kRPGIncomingDuelQuestQuestID] integerValue]
                      friendID:[aDictionary[kRPGIncomingDuelQuestFriendID] integerValue]
                friendUsername:aDictionary[kRPGIncomingDuelQuestFriendUsername]];
}

@end
