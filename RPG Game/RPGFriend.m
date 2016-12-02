//
//  RPGFriend.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriend.h"

NSString * const kRPGFriendID = @"friend_id";
NSString * const kRPGFriendUserName = @"user_name";
NSString * const kRPGFriendCharacterName = @"character_name";
NSString * const kRPGFriendAvatar = @"avatar";
NSString * const kRPGFriendState = @"state";
NSString * const kRPGFriendLevel = @"level";
NSString * const kRPGFriendOnline = @"online";

@interface RPGFriend ()

@property (nonatomic, assign, readwrite) NSUInteger friendID;
@property (nonatomic, copy, readwrite) NSString *userName;
@property (nonatomic, copy, readwrite) NSString *characterName;
@property (nonatomic, copy, readwrite) NSString *avatar;
@property (nonatomic, assign, readwrite) RPGFriendState state;
@property (nonatomic, assign, readwrite) NSInteger level;
@property (nonatomic, assign, readwrite, getter=isOnline) BOOL online;

@end

@implementation RPGFriend

#pragma mark - Init

- (instancetype)initWithID:(NSUInteger)aFriendID
                  userName:(NSString *)aUserName
             characterName:(NSString *)aCharacterName
                    avatar:(NSString *)anAvatar
                     state:(RPGFriendState)aState
                     level:(NSInteger)aLevel
                    online:(BOOL)isOnline
{
  self = [super init];
  
  if (self != nil)
  {
    _friendID = aFriendID;
    _userName = [aUserName copy];
    _characterName = [aCharacterName copy];
    _avatar = [anAvatar copy];
    _state = aState;
    _level = aLevel;
    _online = isOnline;
  }
  
  return self;
}

+ (instancetype)friendWithID:(NSUInteger)aFriendID
                    userName:(NSString *)aUserName
               characterName:(NSString *)aCharacterName
                      avatar:(NSString *)anAvatar
                       state:(RPGFriendState)aState
                       level:(NSInteger)aLevel
                      online:(BOOL)isOnline
{
  return [[[self alloc] initWithID:aFriendID
                          userName:aUserName
                     characterName:aCharacterName
                            avatar:anAvatar
                             state:aState
                             level:aLevel
                            online:isOnline] autorelease];
}

- (instancetype)init
{
  return [self initWithID:-1
                 userName:nil
            characterName:nil
                   avatar:nil
                    state:0
                    level:-1
                   online:NO];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_userName release];
  [_characterName release];
  [_avatar release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGFriendID] = @(self.friendID);
  dictionaryRepresentation[kRPGFriendUserName] = self.userName;
  dictionaryRepresentation[kRPGFriendCharacterName] = self.characterName;
  dictionaryRepresentation[kRPGFriendAvatar] = self.avatar;
  dictionaryRepresentation[kRPGFriendState] = @(self.state);
  dictionaryRepresentation[kRPGFriendLevel] = @(self.level);
  dictionaryRepresentation[kRPGFriendOnline] = @(self.isOnline);
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSUInteger friendID = [aDictionary[kRPGFriendID] integerValue];
  NSString *userName = aDictionary[kRPGFriendUserName];
  NSString *characterName = aDictionary[kRPGFriendCharacterName];
  NSString *avatar = aDictionary[kRPGFriendAvatar];
  NSUInteger state = [aDictionary[kRPGFriendState] integerValue];
  NSInteger level = [aDictionary[kRPGFriendLevel] integerValue];
  BOOL online = [aDictionary[kRPGFriendOnline] boolValue];
  
  return [self initWithID:friendID
                 userName:userName
            characterName:characterName
                   avatar:avatar
                    state:state
                    level:level
                   online:online];
}

@end
