//
//  RPGFriend.m
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGFriend.h"

NSString * const kRPGFriendID = @"friend_id";
NSString * const kRPGFriendUserName = @"username";
NSString * const kRPGFriendState = @"status";
NSString * const kRPGFriendOnline = @"is_online";
NSString * const kRPGFriendCharacter = @"character";
NSString * const kRPGFriendCharacterName = @"name";
NSString * const kRPGFriendCharacterLevel = @"lvl";
NSString * const kRPGFriendCharacterClassID = @"class_id";
NSString * const kRPGFriendCharacterAvatar = @"avatar_id";

@interface RPGFriend ()

@property (nonatomic, assign, readwrite) NSUInteger friendID;
@property (nonatomic, copy, readwrite) NSString *userName;
@property (nonatomic, copy, readwrite) NSString *characterName;
@property (nonatomic, assign, readwrite) NSInteger avatarID;
@property (nonatomic, assign, readwrite) RPGFriendState state;
@property (nonatomic, assign, readwrite) NSInteger level;
@property (nonatomic, assign, readwrite, getter=isOnline) BOOL online;
@property (nonatomic, assign, readwrite) NSInteger classID;

@end

@implementation RPGFriend

#pragma mark - Init

- (instancetype)initWithID:(NSUInteger)aFriendID
                  userName:(NSString *)aUserName
             characterName:(NSString *)aCharacterName
                  avatarID:(NSInteger)anAvatarID
                     state:(RPGFriendState)aState
                     level:(NSInteger)aLevel
                    online:(BOOL)isOnline
                   classID:(NSInteger)aClassID
{
  self = [super init];
  
  if (self != nil)
  {
    _friendID = aFriendID;
    _userName = [aUserName copy];
    _characterName = [aCharacterName copy];
    _avatarID = anAvatarID;
    _state = aState;
    _level = aLevel;
    _online = isOnline;
    _classID = aClassID;
  }
  
  return self;
}

+ (instancetype)friendWithID:(NSUInteger)aFriendID
                    userName:(NSString *)aUserName
               characterName:(NSString *)aCharacterName
                    avatarID:(NSInteger)anAvatarID
                       state:(RPGFriendState)aState
                       level:(NSInteger)aLevel
                      online:(BOOL)isOnline
                     classID:(NSInteger)aClassID
{
  return [[[self alloc] initWithID:aFriendID
                          userName:aUserName
                     characterName:aCharacterName
                            avatarID:anAvatarID
                             state:aState
                             level:aLevel
                            online:isOnline
                           classID:aClassID] autorelease];
}

- (instancetype)init
{
  return [self initWithID:-1
                 userName:nil
            characterName:nil
                   avatarID:-1
                    state:0
                    level:-1
                   online:NO
                  classID:-1];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_userName release];
  [_characterName release];
  
  [super dealloc];
}

#pragma mark - RPGSerializable

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *dictionaryRepresentation = [NSMutableDictionary dictionary];
  dictionaryRepresentation[kRPGFriendID] = @(self.friendID);
  dictionaryRepresentation[kRPGFriendUserName] = self.userName;
  dictionaryRepresentation[kRPGFriendState] = @(self.state);
  dictionaryRepresentation[kRPGFriendOnline] = @(self.isOnline);
  
  NSMutableDictionary *characterRepresetation = [NSMutableDictionary dictionary];
  characterRepresetation[kRPGFriendCharacterName] = self.characterName;
  characterRepresetation[kRPGFriendCharacterLevel] = @(self.level);
  characterRepresetation[kRPGFriendCharacterClassID] = @(self.classID);
  characterRepresetation[kRPGFriendCharacterAvatar] = @(self.avatarID);
  
  dictionaryRepresentation[kRPGFriendCharacter] = characterRepresetation;
  
  return dictionaryRepresentation;
}

- (instancetype)initWithDictionaryRepresentation:(NSDictionary *)aDictionary
{
  NSUInteger friendID = [aDictionary[kRPGFriendID] integerValue];
  NSUInteger state = [aDictionary[kRPGFriendState] integerValue];
  NSString *userName = aDictionary[kRPGFriendUserName];
  BOOL online = [aDictionary[kRPGFriendOnline] boolValue];
  
  NSDictionary *characterRepresentation = aDictionary[kRPGFriendCharacter];
  
  NSString *characterName = characterRepresentation[kRPGFriendCharacterName];
  NSInteger level = [characterRepresentation[kRPGFriendCharacterLevel] integerValue];
  NSInteger classID = [characterRepresentation[kRPGFriendCharacterClassID] integerValue];
  NSInteger avatarID = [characterRepresentation[kRPGFriendCharacterAvatar] integerValue];
  
  return [self initWithID:friendID
                 userName:userName
            characterName:characterName
                 avatarID:avatarID
                    state:state
                    level:level
                   online:online
                  classID:classID];
}

@end
