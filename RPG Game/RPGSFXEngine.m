//
//  RPGsfxEngine.m
//  RPG Game
//
//  Created by Владислав Крут on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGsfxEngine.h"
#import "CMOpenALSoundManager.h"


static RPGSFXEngine *sharedSFXEngine = nil;

@interface RPGSFXEngine ()

@property (nonatomic, retain) CMOpenALSoundManager *soundManager;

@end

@implementation RPGSFXEngine

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _soundManager = [CMOpenALSoundManager new];
        _isPlaying = YES;
    }
    return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [_soundManager release];
    [super dealloc];
}

#pragma mark - Singleton

+ (instancetype)sharedSFXEngine
{
    @synchronized(self)
    {
        if(sharedSFXEngine == nil)
        {
            sharedSFXEngine = [[super allocWithZone:NULL] init];
        }
    }
    return sharedSFXEngine;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedSFXEngine] retain];
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

#pragma mark - Actions

- (void)changeVolume:(double)volume
{
    [self.soundManager setSoundEffectsVolume:volume];
}

- (void)toggle:(BOOL)state
{
    self.isPlaying = state;
}

- (void)playSFXNamed:(NSString *)name
{
    if (self.isPlaying)
    {
        NSString *pathToSound = [NSString stringWithFormat:@"Sounds.bundle/SFX/%@.wav", name];
        self.soundManager.soundFileNames = [NSArray arrayWithObject:pathToSound];
        [self.soundManager playSoundWithID:0];
    }
}

- (void)playSFXWithSpellID:(NSUInteger)identifier
{
    [self playSFXNamed:[NSString stringWithFormat:@"Spell-%lu", identifier]];
}

- (double)getVolume
{
    return self.soundManager.soundEffectsVolume;
}

@end
