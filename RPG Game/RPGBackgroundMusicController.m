//
//  RPGBackgroundMusicController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBackgroundMusicController.h"

static RPGBackgroundMusicController *sharedBackgroundMusicController = nil;

@implementation RPGBackgroundMusicController

#pragma mark - Music Changing

- (void)switchToBattle
{
    NSLog(@"Switched to battle");
}

- (void)switchToPeace
{
    NSLog(@"Switched to peace");
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSURL *fileURL = [[[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"m4a"]] autorelease];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
        _player.numberOfLoops = 1;
        _player.delegate = self;
        
        [AVAudioSession sharedInstance];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruption:) name:AVAudioSessionInterruptionNotification object:nil];
        
        NSError *setCategoryError = nil;
        
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: &setCategoryError];
        if (setCategoryError)
        {
            NSLog(@"Error setting category! %@", setCategoryError);
        }
        [_player play];
    }
    return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
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
