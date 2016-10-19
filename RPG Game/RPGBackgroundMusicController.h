//
//  RPGBackgroundMusicController.h
//  RPG Game
//
//  Created by Владислав Крут on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface RPGBackgroundMusicController : NSObject <AVAudioPlayerDelegate, AVAudioSessionDelegate>

@property (nonatomic) BOOL isPlaying;

+ (instancetype)sharedBackgroundMusicController;

#pragma mark - API

- (void)switchToBattle;
- (void)switchToPeace;

- (void)changeVolume:(double)volume;
- (double)getVolume;

- (void)toggle:(BOOL)state;

@end
