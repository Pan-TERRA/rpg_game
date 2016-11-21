//
//  NSUserDefaults+RPGSessionInfo.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (RPGSessionInfo)

@property (nonatomic) NSString *sessionUsername;
@property (nonatomic) NSString *sessionAvatar;
@property (nonatomic) NSString *sessionToken;
  // TODO: remove
@property (nonatomic) NSInteger sessionGold;
@property (nonatomic) NSInteger sessionCrystals;
  // TODO: Remove hp, attack
@property (nonatomic) NSArray *sessionCharacters;
  // TODO: In future add characterIDbyName: or currentCharacterID
@property (nonatomic, readonly) NSInteger characterID;
@property (nonatomic, readonly) NSString *characterNickName;

@end
