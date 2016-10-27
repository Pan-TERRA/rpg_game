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
@property (nonatomic) NSInteger sessionGold;
@property (nonatomic) NSInteger sessionCrystals;
@property (nonatomic) NSArray *sessionCharacters;

@end
