//
//  NSUserDefaults+RPGSessionInfo.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (RPGSessionInfo)

@property (nonatomic, readonly) NSString *sessionUsername;
@property (nonatomic, readonly) NSString *sessionAvatar;
@property (nonatomic, readonly) NSString *sessionToken;
@property (readonly) NSInteger sessionGold;
@property (readonly) NSInteger sessionCrystals;
@property (nonatomic, readonly) NSArray *sessionCharacters;

@end
