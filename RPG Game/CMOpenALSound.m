//
//  CMOpenALSound.m
//
//  Created by Alex Restrepo on 5/19/09.
//  Copyright 2009 Colombiamug. All rights reserved.
//
//	Portions of this code are adapted from Apple's oalTouch example and
//	http://www.gehacktes.net/2009/03/iphone-programming-part-6-multiple-sounds-with-openal/


#import "CMOpenALSound.h"
#import "AppleOpenALSupport.h"

@interface CMOpenALSound()

@property (nonatomic, retain) NSMutableArray *temporarySounds;
@property (nonatomic, copy) NSString *sourceFileName;

- (BOOL)loadSoundFile:(NSString *)file doesLoop:(BOOL)loops;

@end

@implementation CMOpenALSound
@synthesize error, temporarySounds, duration, sourceFileName;

#pragma mark - Init

- (instancetype)initWithSoundFile:(NSString *)file doesLoop:(BOOL)loops
{
  self = [super init];
  if (self)
  {
    if(![self loadSoundFile:file doesLoop:loops])
    {
      NSLog(@"Failed to load the sound file: %@...", file);
      [self release];
      return nil;
    }
    self.sourceFileName = file;
    
    //temporary sound queue
    self.temporarySounds = [NSMutableArray array];
    
    //default volume/pitch
    self.volume = 1.0;
    self.pitch = 1.0;
  }
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  NSLog(@"Deallocing sound: sourceID:%u, bufferID:%u", sourceID, bufferID);
  
  //delete base source...
  alDeleteSources(1, &sourceID);
  
  //and all temporary sources...
  for (NSNumber *tmpSourceID in temporarySounds)
  {
    //tmpSourceID is the source ID for the temporary sound
    NSUInteger srcID = [tmpSourceID unsignedIntegerValue];
    alDeleteSources(1, ((ALuint*)&srcID));
  }
  [temporarySounds release];
  
  //now the buffer, since it wasn't copied to openAL
  alDeleteBuffers(1, &bufferID);
  
  if (bufferData)
  {
    free(bufferData);
    bufferData = NULL;
  }
  [sourceFileName release];
  [super dealloc];
}

#pragma mark - Loading

- (BOOL)loadSoundFile:(NSString *)fileName doesLoop:(BOOL)loops
{
  ALenum  format;
  ALsizei size;
  ALsizei freq;
  error = AL_NO_ERROR;
  alGetError(); //clear any previous error...
  
  //get the URL for the sound file...
  NSBundle *bundle = [NSBundle mainBundle];
  NSString *path = [bundle pathForResource:[fileName stringByDeletingPathExtension]
                                    ofType:[fileName pathExtension]];
  
  if (!path)
  {
    return NO;
  }
  
  CFURLRef fileURL = (CFURLRef)[[NSURL fileURLWithPath:path] retain];
  
  if (!fileURL)
  {
    NSLog(@"file: %@ not found.", fileName);
    return NO;
  }
  
  // get audio data from file
  bufferData = MyGetOpenALAudioData(fileURL, &size, &format, &freq, &duration);
  CFRelease(fileURL);
  
  // grab a buffer ID from openAL
  alGenBuffers(1, &bufferID);
  
  // load the awaiting data blob into the openAL buffer.
  // http://developer.apple.com/iphone/library/technotes/tn2008/tn2199.html
  // Use the alBufferDataStatic API, found in the oalStaticBufferExtension.h header file,
  // instead of the standard alBufferData function. This eliminates extra buffer copies by allowing your application to own
  // the audio data memory used by the buffer objects.
  alBufferDataStaticProc(bufferID, format, bufferData, size, freq);
  
  // grab a source ID from openAL, this will be the base source ID
  alGenSources(1, &sourceID);
		
  // attach the buffer to the source
  alSourcei(sourceID, AL_BUFFER, bufferID);
  
  if (loops)
  {
    alSourcei(sourceID, AL_LOOPING, AL_TRUE);
  }
  
  if((error = alGetError()) != AL_NO_ERROR)
  {
    NSLog(@"error loading sound: %x\n", error);
    return NO;
  }
  
  return YES;
}

#pragma mark - Playback
- (void)deleteTemporarySource
{
  //dequeue a sourceID from the temporary sound queue
  NSUInteger tmpSourceID = [[temporarySounds objectAtIndex:0] unsignedIntegerValue];
  [temporarySounds removeObjectAtIndex:0];
  
  //	NSLog(@"Deleting temporary source: sourceID: %u, [temporarySounds count]:%lu", (ALuint)tmpSourceID, (unsigned long)[temporarySounds count]);
  //and delete the source to make it available again for another sound.
  alDeleteSources(1, (ALuint*)&tmpSourceID);
  
}

- (BOOL)play
{
  if([self isPlaying]) //see if the base source is busy...
  {
    //if so, create a new source
    NSUInteger tmpSourceID;
    //alGenSources(1, &tmpSourceID);
    alGenSources(1, (ALuint*)&tmpSourceID);
    
    //attach the buffer to the source
    alSourcei((ALuint)tmpSourceID, AL_BUFFER, bufferID);
    alSourcePlay((ALuint)tmpSourceID);
    
    //add the sound id to the play queue so we can dispose of it later
    [temporarySounds addObject: [NSNumber numberWithUnsignedInteger:tmpSourceID]];
    
    //a "callback" for when the sound is done playing +0.1 secs
    [self performSelector:@selector(deleteTemporarySource)
               withObject:nil
               afterDelay:(duration * pitch) + 0.1];
    
    return ((error = alGetError()) != AL_NO_ERROR);
  }
  
  //if the base source isn't busy, just use that one...
  alSourcePlay(sourceID);
  return ((error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)stop
{
  alSourceStop(sourceID);
  return ((error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)pause
{
  alSourcePause(sourceID);
  return ((error = alGetError()) != AL_NO_ERROR);
}

- (BOOL)rewind
{
  alSourceRewind(sourceID);
  return ((error = alGetError()) != AL_NO_ERROR);
}

// returns whether the BASE source is playing or not
- (BOOL)isPlaying
{
  ALenum state;
  alGetSourcei(sourceID, AL_SOURCE_STATE, &state);
  
  return (state == AL_PLAYING);
}

// returns YES if the base or any temporary sounds are playing...
- (BOOL)isAnyPlaying
{
  return [self isPlaying] || [temporarySounds count] > 0;
}

#pragma mark - Properties
- (ALfloat)volume
{
  return volume;
}

- (void)setVolume:(ALfloat)newVolume
{
  volume = MAX(MIN(newVolume, 1.0f), 0.0f); //cap to 0-1
  alSourcef(sourceID, AL_GAIN, volume);
  
  //now set the volume for any temporary sounds...
  for (NSNumber *tmpSourceID in temporarySounds)
  {
    //tmpSourceID is the source ID for the temporary sound
    alSourcef((ALuint)[tmpSourceID unsignedIntegerValue], AL_GAIN, volume);
  }
}

- (ALfloat)pitch
{
  return pitch;
}

- (void)setPitch:(ALfloat)newPitch
{
  pitch = newPitch;
  
  alSourcef(sourceID, AL_PITCH, pitch);
  
  for (NSNumber *tmpSourceID in temporarySounds)
  {
    //tmpSourceID is the source ID for the temporary sound
    alSourcef((ALuint)[tmpSourceID unsignedIntegerValue], AL_PITCH, pitch);
  }
}
@end
