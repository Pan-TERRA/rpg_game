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

- (void)changeVolume:(double)volume
{
    [self.soundManager setSoundEffectsVolume:volume];
}

- (void)toggle:(BOOL)state
{
    self.state = state;
}

- (void)playSFXNamed:(NSString *)name
{
    if (self.state)
    {
        self.soundManager.soundFileNames = [NSArray arrayWithObject:[NSString stringWithFormat:@"Sounds.bundle/SFX/%@.wav", name]];
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

#pragma mark - Singleton

+ (instancetype)sharedSFXEngine
{
    @synchronized(self)
    {
        if(sharedSFXEngine == nil)
        {
            sharedSFXEngine = [[super allocWithZone:NULL] init];
            sharedSFXEngine.soundManager = [[CMOpenALSoundManager new] autorelease];
            sharedSFXEngine.state = YES;
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


@end
