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

- (void)playSFXNamed:(NSString *)name
{
    self.soundManager.soundFileNames = [NSArray arrayWithObject:@"Sounds.bundle/SFX/SPLAT_Crush01.wav"];
    [self.soundManager playSoundWithID:0];
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
