//
//  NSUserDefaults+RPGVolumeSettings.h
//  RPG Game
//
//  Created by Владислав Крут on 10/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (RPGVolumeSettings)

@property (nonatomic, assign, readwrite, getter=isMusicPlaying) BOOL musicPlaying;
@property (nonatomic, assign, readwrite, getter=isSoundsPlaying) BOOL soundsPlaying;
@property (nonatomic, assign, readwrite) double musicVolume;
@property (nonatomic, assign, readwrite) double soundsVolume;

@end
