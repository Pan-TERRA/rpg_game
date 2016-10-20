//
//  NSUserDefaults+RPGSessionInfo.h
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (RPGSessionInfo)

@property (nonatomic, copy, readonly) NSString *sessionUsername;
@property (nonatomic, copy, readonly) NSString *sessionAvatar;
@property (nonatomic, copy, readonly) NSString *sessionToken;
@property (nonatomic, assign, readonly) NSInteger sessionGold;
@property (nonatomic, assign, readonly) NSInteger sessionCrystals;
@property (nonatomic, retain, readonly) NSArray *sessionCharacters;

@end
