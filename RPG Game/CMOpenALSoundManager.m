//
//  CMOpenALSoundManager.m
//
//  Created by Alex Restrepo on 5/19/09.
//  Copyright 2009 Colombiamug. All rights reserved.
//
//	Portions of this code are adapted from Apple's oalTouch example and
//	http://www.gehacktes.net/2009/03/iphone-programming-part-6-multiple-sounds-with-openal/


#import "CMOpenALSoundManager.h"
#import "CMOpenALSound.h"

@interface CMOpenALSoundManager()

@property (nonatomic, retain) NSMutableDictionary *soundDictionary;
@property (nonatomic) BOOL interrupted;
@property (nonatomic) BOOL isiPodAudioPlaying;

@end

@interface CMOpenALSoundManager(private)
- (NSString *) keyForSoundID:(NSUInteger)soundID;
- (void) setupAudioCategorySilenceIpod:(BOOL)silenceIpod;
- (void) shutdownOpenAL;
- (BOOL) startupOpenAL;
@end

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

//audio interruption callback...
void interruptionListenerCallback (void *inUserData, UInt32 interruptionState) 
{
    CMOpenALSoundManager *soundMgr = (CMOpenALSoundManager *) inUserData;
	
    if (interruptionState == kAudioSessionBeginInterruption) 
	{		
		NSLog(@"Start audio interruption");
		[soundMgr beginInterruption];
		soundMgr.interrupted = YES;
    } 
	else if ((interruptionState == kAudioSessionEndInterruption) && soundMgr.interrupted)
	{
		NSLog(@"Stop audio interruption");
		[soundMgr endInterruption];
        soundMgr.interrupted = NO;
    }
}

@implementation CMOpenALSoundManager
@synthesize soundDictionary, soundFileNames, isiPodAudioPlaying, interrupted;


#pragma mark - Init/Dealloc
- (instancetype)init
{
	self = [super init];		
	if (self)
	{
		self.soundDictionary = [NSMutableDictionary dictionary];
		self.soundEffectsVolume = 1.0;

		//isiPodAudioPlaying = YES; 
		[self endInterruption];
	}
	return self;
}

// start up openAL
- (BOOL)startupOpenAL
{				
	ALCcontext	*context = NULL;
	ALCdevice	*device = NULL;

	// Initialization
	device = alcOpenDevice(NULL); // select the "preferred device"
	if(!device)
    {
        return NO;
    }
	// use the device to make a context
	context = alcCreateContext(device, NULL);
	if(!context)
    {
        return NO;
    }
	
	// set my context to the currently active one
	alcMakeContextCurrent(context);
	
//	NSLog(@"oal inited ok");
	return YES;
}

- (void) dealloc
{
	NSLog(@"CMOpenALSoundManager dealloc");
	
	[self shutdownOpenAL];
	
	[soundFileNames release];
	[soundDictionary release];

	[super dealloc];
}

- (void) shutdownOpenAL
{
	
	ALCcontext	*context = NULL;
    ALCdevice	*device = NULL;
	
	//Get active context (there can only be one)
    context = alcGetCurrentContext();
	
    //Get device for active context
    device = alcGetContextsDevice(context);
	
    //Release context
    alcDestroyContext(context);
	
    //Close device
    alcCloseDevice(device);
}

#pragma mark - Audio Session Management

- (void) beginInterruption
{		
	NSLog(@"begin interruption");

	[self shutdownOpenAL];
	
	if(!self.isiPodAudioPlaying)
	{
		UInt32	sessionCategory = kAudioSessionCategory_MediaPlayback;
		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
		AudioSessionSetActive(YES);
	}
	else
	{
		UInt32	sessionCategory = kAudioSessionCategory_UserInterfaceSoundEffects;
		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);
		AudioSessionSetActive(YES);
	}
	
	AudioSessionSetActive(NO);
}

- (void) endInterruption
{
	NSLog(@"end interruption");
	[self setupAudioCategorySilenceIpod: NO];
	[self startupOpenAL];	
	
	AudioSessionSetActive(YES);
}

- (void) setupAudioCategorySilenceIpod:(BOOL)silenceIpod;
{
	UInt32 audioIsAlreadyPlaying;
	UInt32 propertySize = sizeof(audioIsAlreadyPlaying);
	
	
	//query audio hw to see if ipod is playing...
	OSStatus err = AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &propertySize, &audioIsAlreadyPlaying);	
	if(err)
    {
		NSLog(@"AudioSessionGetProperty error:%i",err);
    }
//	NSLog(@"kAudioSessionProperty_OtherAudioIsPlaying = %@", audioIsAlreadyPlaying ? @"YES" : @"NO");
	
	if(audioIsAlreadyPlaying && !silenceIpod)
	{
		self.isiPodAudioPlaying = YES;
		
		//register session as ambient sound so our effects mix with ipod audio
		UInt32	sessionCategory = kAudioSessionCategory_AmbientSound;
		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);		
	}
	else
	{
		self.isiPodAudioPlaying = NO;
		
		//register session as solo ambient sound so the ipod is silenced, and we can use hardware codecs for background audio
		UInt32	sessionCategory = kAudioSessionCategory_SoloAmbientSound;
		AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(sessionCategory), &sessionCategory);		
	}		
}

#pragma mark - Effects Playback
// grab the filename (key) from the filenames array
- (NSString *) keyForSoundID:(NSUInteger)soundID
{
	if(soundID >= [soundFileNames count])
    {
		return nil;
    }
    return [soundFileNames objectAtIndex:soundID];
}

- (void) playSoundWithID:(NSUInteger)soundID
{	
	//get sound key
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile)
    {
        return;
    }
    
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];
	
	if(!sound)
	{
		//create a new sound
		sound = [[CMOpenALSound alloc] initWithSoundFile:soundFile doesLoop:NO]; //this will return nil on failure
		
		if(!sound) //error
        {
			return;
        }
		[soundDictionary setObject:sound forKey:soundFile];
		[sound release];
	}
	
	[sound play];
	sound.volume = self.soundEffectsVolume;
}

- (void) stopSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile)
    {
        return;
    }
	
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];		
	[sound stop];
}

- (void) pauseSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
    if(!soundFile)
    {
        return;
    }
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];		
	[sound stop];
}

- (void) rewindSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile)
    {
        return;
    }
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];
	[sound rewind];
}

- (BOOL) isPlayingSoundWithID:(NSUInteger)soundID
{
	NSString *soundFile = [self keyForSoundID:soundID];
	if(!soundFile)
    {
        return NO;
    }
	CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];		
	return [sound isAnyPlaying];
}

#pragma mark - Properties

- (float) soundEffectsVolume
{
	return soundEffectsVolume;
}

- (void) setSoundEffectsVolume:(float) newVolume
{
	soundEffectsVolume = newVolume;
	for(NSString *key in soundDictionary)
	{
		((CMOpenALSound *)[soundDictionary objectForKey:key]).volume = newVolume;
	}
}
@end
