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

@property (nonatomic, assign, readwrite, getter=isPlaying) BOOL playing;
@property (nonatomic, assign, readwrite) double volume;

+ (instancetype)sharedBackgroundMusicController;

#pragma mark - API

- (void)switchToBattle;
- (void)switchToPeace;

- (void)toggle:(BOOL)aState;

@end
