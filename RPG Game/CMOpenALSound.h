//
//  CMOpenALSound.h
//
//  Created by Alex Restrepo on 5/19/09.
//  Copyright 2009 Colombiamug. All rights reserved.
//
//	Portions of this code are adapted from Apple's oalTouch example and
//	http://www.gehacktes.net/2009/03/iphone-programming-part-6-multiple-sounds-with-openal/


#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

@interface CMOpenALSound : NSObject
{
  ALuint			bufferID;
  ALuint			sourceID;			//base source ID
  ALdouble		duration;			//duration of the sound in seconds
  ALfloat			volume;				//volume [0 - 1]
  ALfloat			pitch;				//speed
  
  ALenum			error;
  ALvoid			*bufferData;		//holds the actual sound data
  
  NSMutableArray	*temporarySounds;	//holds source IDs to temporary sounds (sounds played when the base source was busy)
  NSString		*sourceFileName;
}

@property (nonatomic, readonly) ALenum error;
@property (nonatomic, readonly) ALdouble duration;
@property (nonatomic) ALfloat volume;
@property (nonatomic) ALfloat pitch;
@property (nonatomic, copy, readonly) NSString *sourceFileName;

- (instancetype)initWithSoundFile:(NSString *)file doesLoop:(BOOL)loops;

- (BOOL) play;
- (BOOL) stop;
- (BOOL) pause;
- (BOOL) rewind;
- (BOOL) isPlaying;
- (BOOL) isAnyPlaying;
@end
