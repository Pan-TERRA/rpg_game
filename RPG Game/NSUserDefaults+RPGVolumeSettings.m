//
//  NSUserDefaults+RPGVolumeSettings.m
//  RPG Game
//
//  Created by Владислав Крут on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "NSUserDefaults+RPGVolumeSettings.h"

NSString * const kRPGUserVolumeSettingsKeyIsMusicPlaying = @"RPG_IS_MUSIC_PLAYING";
NSString * const kRPGUserVolumeSettingsKeyIsSoundsPlaying = @"RPG_IS_SOUNDS_PLAYING";
NSString * const kRPGUserVolumeSettingsKeyMusicVolume = @"RPG_MUSIC_VOLUME";
NSString * const kRPGUserVolumeSettingsKeySoundsVolume = @"RPG_SOUNDS_VOLUME";

@implementation NSUserDefaults (RPGVolumeSettings)

- (BOOL)isMusicPlaying
{
  BOOL result = TRUE;
  if ([self objectForKey:kRPGUserVolumeSettingsKeyIsMusicPlaying])
  {
    result = [self boolForKey:kRPGUserVolumeSettingsKeyIsMusicPlaying];
  }
  return result;
}

- (void)setIsMusicPlaying:(BOOL)anIsMusicPlaying
{
  [self setBool:anIsMusicPlaying forKey:kRPGUserVolumeSettingsKeyIsMusicPlaying];
}

- (BOOL)isSoundsPlaying
{
  BOOL result = TRUE;
  if ([self objectForKey:kRPGUserVolumeSettingsKeyIsSoundsPlaying])
  {
    result = [self boolForKey:kRPGUserVolumeSettingsKeyIsSoundsPlaying];
  }
  return result;

}

- (void)setIsSoundsPlaying:(BOOL)anIsSoundsPlaying
{
  [self setBool:anIsSoundsPlaying forKey:kRPGUserVolumeSettingsKeyIsSoundsPlaying];
}

- (double)musicVolume
{
  double result = 1.0;
  if ([self objectForKey:kRPGUserVolumeSettingsKeyMusicVolume])
  {
    result = [self doubleForKey:kRPGUserVolumeSettingsKeyMusicVolume];
  }
  return result;
}

- (void)setMusicVolume:(double)aMusicVolume
{
  [self setDouble:aMusicVolume forKey:kRPGUserVolumeSettingsKeyMusicVolume];
}

- (double)soundsVolume
{
  double result = 1.0;
  if ([self objectForKey:kRPGUserVolumeSettingsKeySoundsVolume])
  {
    result = [self doubleForKey:kRPGUserVolumeSettingsKeySoundsVolume];
  }
  return result;
}

- (void)setSoundsVolume:(double)aSoundsVolume
{
  [self setDouble:aSoundsVolume forKey:kRPGUserVolumeSettingsKeySoundsVolume];
}
@end
