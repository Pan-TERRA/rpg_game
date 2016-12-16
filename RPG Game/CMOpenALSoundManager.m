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

@end

@implementation CMOpenALSoundManager
@synthesize soundDictionary, soundFileNames;

#pragma mark - Init
- (instancetype)init
{
  self = [super init];
  if (self)
  {
    self.soundDictionary = [NSMutableDictionary dictionary];
    self.soundEffectsVolume = 1.0;
    
    [self startupOpenAL];
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [self shutdownOpenAL];
  [soundFileNames release];
  [soundDictionary release];
  
  [super dealloc];
}

#pragma mark - OpenAL
- (BOOL)startupOpenAL
{
  ALCcontext	*context = NULL;
  ALCdevice	*device = NULL;
  
  device = alcOpenDevice(NULL); // select the "preferred device"
  
  if (!device)
  {
    return NO;
  }
  
  context = alcCreateContext(device, NULL);
  
  if (!context)
  {
    return NO;
  }
  
  alcMakeContextCurrent(context);
  
  return YES;
}

- (void)shutdownOpenAL
{
  ALCcontext	*context = NULL;
  ALCdevice	*device = NULL;
  
  context = alcGetCurrentContext();
  device = alcGetContextsDevice(context);
  alcDestroyContext(context);
  alcCloseDevice(device);
}

#pragma mark - Audio Session Management

- (void)beginInterruption
{
  NSLog(@"begin interruption");
  [self shutdownOpenAL];
}

- (void)endInterruption
{
  NSLog(@"end interruption");
  [self startupOpenAL];
}

#pragma mark - Effects Playback

- (NSString *)keyForSoundID:(NSUInteger)soundID
{
  if (soundID >= [soundFileNames count])
  {
    return nil;
  }
  
  return [soundFileNames objectAtIndex:soundID];
}

- (void)playSoundWithID:(NSUInteger)soundID
{
  //get sound key
  NSString *soundFile = [self keyForSoundID:soundID];
  
  if (!soundFile)
  {
    return;
  }
  
  CMOpenALSound *sound = [soundDictionary objectForKey:soundFile];
  
  if (!sound)
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

#pragma mark - Properties

- (float)soundEffectsVolume
{
  return soundEffectsVolume;
}

- (void)setSoundEffectsVolume:(float) newVolume
{
  soundEffectsVolume = newVolume;
  for(NSString *key in soundDictionary)
  {
    ((CMOpenALSound *)[soundDictionary objectForKey:key]).volume = newVolume;
  }
}
@end
