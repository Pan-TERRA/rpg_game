//
//  NSUserDefaults+RPGVolumeSettings.m
//  RPG Game
//
//  Created by Владислав Крут on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "NSUserDefaults+RPGVolumeSettings.h"
#import "RPGUserVolumeSettingsKeys.h"

@implementation NSUserDefaults (RPGVolumeSettings)

- (BOOL)isMusicPlaying
{
  return [self boolForKey:kRPGUserVolumeSettingsKeyIsMusicPlaying];
}

- (void)setIsMusicPlaying:(BOOL)anIsMusicPlaying
{
  [self setBool:anIsMusicPlaying forKey:kRPGUserVolumeSettingsKeyIsMusicPlaying];
}

- (BOOL)isSoundsPlaying
{
  return [self boolForKey:kRPGUserVolumeSettingsKeyIsSoundsPlaying];
}

- (void)setIsSoundsPlaying:(BOOL)anIsSoundsPlaying
{
  [self setBool:anIsSoundsPlaying forKey:kRPGUserVolumeSettingsKeyIsSoundsPlaying];
}

- (double)musicVolume
{
  return [self doubleForKey:kRPGUserVolumeSettingsKeyMusicVolume];
}

- (void)setMusicVolume:(double)aMusicVolume
{
  [self setDouble:aMusicVolume forKey:kRPGUserVolumeSettingsKeyMusicVolume];
}

- (double)soundsVolume
{
  return [self doubleForKey:kRPGUserVolumeSettingsKeySoundsVolume];
}

- (void)setSoundsVolume:(double)aSoundsVolume
{
  [self setDouble:aSoundsVolume forKey:kRPGUserVolumeSettingsKeySoundsVolume];
}
@end
