//
//  NSUserDefaults+RPGSessionInfo.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 10/18/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGUserSessionKeys.h"

@implementation NSUserDefaults (RPGSessionInfo)

- (NSString *)sessionUsername
{
  return [self objectForKey:kRPGUserSessionKeyUsername];
}

- (NSString *)sessionAvatar
{
  return [self objectForKey:kRPGUserSessionKeyAvatar];
}

- (NSString *)sessionToken
{
  return [self objectForKey:kRPGUserSessionKeyToken];
}

- (NSInteger)sessionGold
{
  return [self integerForKey:kRPGUserSessionKeyGold];
}

- (NSInteger)sessionCrystals
{
  return [self integerForKey:kRPGUserSessionKeyCrystals];
}

- (NSArray *)sessionCharacters
{
  return [self objectForKey:kRPGUserSessionKeyCharacters];
}

@end