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

#pragma mark - *** Accessors ***

#pragma mark Username

- (void)setSessionUsername:(NSString *)aSessionUsername
{
  [self setObject:aSessionUsername forKey:kRPGUserSessionKeyUsername];
}

- (NSString *)sessionUsername
{
  return [self objectForKey:kRPGUserSessionKeyUsername];
}

#pragma mark Avatar

- (void)setSessionAvatar:(NSString *)aSessionAvatar
{
  [self setObject:aSessionAvatar forKey:kRPGUserSessionKeyAvatar];
}

- (NSString *)sessionAvatar
{
  return [self objectForKey:kRPGUserSessionKeyAvatar];
}

#pragma mark Token

- (void)setSessionToken:(NSString *)aSessionToken
{
  [self setObject:aSessionToken forKey:kRPGUserSessionKeyToken];
}

- (NSString *)sessionToken
{
  return [self objectForKey:kRPGUserSessionKeyToken];
}

#pragma mark Gold

- (void)setSessionGold:(NSInteger)aSessionGold
{
  [self setInteger:aSessionGold forKey:kRPGUserSessionKeyGold];
}

- (NSInteger)sessionGold
{
  return [self integerForKey:kRPGUserSessionKeyGold];
}

#pragma mark Crystals

- (void)setSessionCrystals:(NSInteger)aSessionCrystals
{
  [self setInteger:aSessionCrystals forKey:kRPGUserSessionKeyCrystals];
}

- (NSInteger)sessionCrystals
{
  return [self integerForKey:kRPGUserSessionKeyCrystals];
}

#pragma mark Characters

- (void)setSessionCharacters:(NSArray *)aSessionCharacters
{
  [self setObject:aSessionCharacters forKey:kRPGUserSessionKeyCharacters];
}

- (NSArray *)sessionCharacters
{
  return [self objectForKey:kRPGUserSessionKeyCharacters];
}

#pragma mark -

- (NSInteger)characterID
{
  return [[self.sessionCharacters firstObject][@"char_id"] integerValue];
}

- (NSString *)characterNickName
{
  return [self.sessionCharacters firstObject][@"name"];
}

- (NSInteger)characterClassID
{
  return [[self.sessionCharacters firstObject][@"class_id"] integerValue];
}

- (NSInteger)characterAvatarID
{
  return [[self.sessionCharacters firstObject][@"avatar_id"] integerValue];
}

#pragma mark Selected arena skills

- (void)setSelectedArenaSkills:(NSArray *)selectedArenaSkills
{
  [self setObject:selectedArenaSkills forKey:kRPGUserSessionKeySelectedArenaSkills];
}

- (NSArray *)selectedArenaSkills
{
  return [self objectForKey:kRPGUserSessionKeySelectedArenaSkills];
}

@end
