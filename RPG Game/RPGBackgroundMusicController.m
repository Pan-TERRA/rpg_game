//
//  RPGBackgroundMusicController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBackgroundMusicController.h"

static RPGBackgroundMusicController *sharedBackgroundMusicController = nil;

@interface RPGBackgroundMusicController ()

@property (nonatomic, retain) AVAudioPlayer *peacePlayer;
@property (nonatomic, retain) AVAudioPlayer *battlePlayer;

@end

@implementation RPGBackgroundMusicController

#pragma mark - Music Changing

- (void)switchToBattle
{
    if (self.state)
    {
        [self.peacePlayer pause];
        [self.battlePlayer play];
    }
}

- (void)switchToPeace
{
    if (self.state)
    {
        [self.battlePlayer pause];
        [self.peacePlayer play];
    }
}

- (void)changeVolume:(double)volume
{
    self.peacePlayer.volume = volume;
    self.battlePlayer.volume = volume;
}

- (void)toggle:(BOOL)state
{
    self.state = state;
    if (state)
    {
        [self switchToPeace];
    }
    else
    {
        [self.peacePlayer pause];
        [self.battlePlayer pause];
    }
}

- (double)getVolume
{
    return self.peacePlayer.volume;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSURL *peaceMusic = [[[NSURL alloc] initFileURLWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Sounds.bundle/BackGround/PeaceMusic.mp3"]] autorelease];
        _peacePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:peaceMusic error:nil];
        
        _peacePlayer.numberOfLoops = -1;
        _peacePlayer.delegate = self;
        
        NSURL *battleMusic = [[[NSURL alloc] initFileURLWithPath:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Sounds.bundle/BackGround/BattleMusic.mp3"]] autorelease];
        _battlePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:battleMusic error:nil];
        
        _battlePlayer.numberOfLoops = -1;
        _battlePlayer.delegate = self;
        
        [AVAudioSession sharedInstance];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruption:) name:AVAudioSessionInterruptionNotification object:nil];
        
        NSError *setCategoryError = nil;
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
        if (setCategoryError)
        {
            NSLog(@"Error setting category! %@", setCategoryError);
        }
        
        self.state = YES;
        
        if (self.state)
        {
            [_peacePlayer play];
        }
    }
    return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [_peacePlayer release];
    [_battlePlayer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark - Singleton

+ (id)sharedBackgroundMusicController
{
    @synchronized(self)
    {
        if(sharedBackgroundMusicController == nil)
        {
            sharedBackgroundMusicController = [[super allocWithZone:NULL] init];
        }
    }
    return sharedBackgroundMusicController;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedBackgroundMusicController] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return UINT_MAX;
}

- (oneway void)release
{
    
}

- (id)autorelease
{
    return self;
}

#pragma mark - Notification Listening
- (void) interruption:(NSNotification*)notification
{
    //http://stackoverflow.com/questions/13078901/cocos2d-2-1-delegate-deprecated-in-ios-6-how-do-i-set-the-delegate-for-this
    
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSUInteger interuptionType = (NSUInteger)[interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey];
    
    if (interuptionType == AVAudioSessionInterruptionTypeBegan)
    {
        [self beginInterruption];
    }
    else if (interuptionType == AVAudioSessionInterruptionTypeEnded)
    {
        [self endInterruption];
    }
}


@end
