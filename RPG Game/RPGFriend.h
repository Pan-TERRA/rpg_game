//
//  RPGFriend.h
//  RPG Game
//
//  Created by Владислав Крут on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPGSerializable.h"

typedef NS_ENUM(NSUInteger, RPGFriendState)
{
  kRPGFriendStateAccept,
  kRPGFriendStateIncoming,
  kRPGFriendStateOutgoing
};

@interface RPGFriend : NSObject <RPGSerializable>

@property (nonatomic, assign, readonly) NSUInteger friendID;
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *characterName;
@property (nonatomic, copy, readonly) NSString *avatar;
@property (nonatomic, assign, readonly) RPGFriendState state;
@property (nonatomic, assign, readonly) NSInteger level;
@property (nonatomic, assign, readonly, getter=isOnline) BOOL online;

- (instancetype)initWithID:(NSUInteger)aFriendID
                  userName:(NSString *)aUserName
             characterName:(NSString *)aCharacterName
                    avatar:(NSString *)anAvatar
                     state:(RPGFriendState)aState
                     level:(NSInteger)aLevel
                    online:(BOOL)isOnline NS_DESIGNATED_INITIALIZER;

+ (instancetype)friendWithID:(NSUInteger)aFriendID
                    userName:(NSString *)aUserName
               characterName:(NSString *)aCharacterName
                      avatar:(NSString *)anAvatar
                       state:(RPGFriendState)aState
                       level:(NSInteger)aLevel
                      online:(BOOL)isOnline;

@end