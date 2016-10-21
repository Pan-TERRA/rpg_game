//
//  CMOpenALSoundManager.h
//
//  Created by Alex Restrepo on 5/19/09.
//  Copyright 2009 Colombiamug. All rights reserved.
//
//	Portions of this code are adapted from Apple's oalTouch example and
//	http://www.gehacktes.net/2009/03/iphone-programming-part-6-multiple-sounds-with-openal/


#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>


@class CMOpenALSound;

@interface CMOpenALSoundManager : NSObject 
{	
	NSMutableDictionary	*soundDictionary;	// stores our soundkeys
	NSArray				*soundFileNames;	// array that holds the filenames for the sounds, they will be referenced by index

	float				soundEffectsVolume;
}

@property (nonatomic, retain) NSArray *soundFileNames;
@property (nonatomic) float soundEffectsVolume;

- (void) beginInterruption;	// handle os sound interruptions
- (void) endInterruption;

- (void) playSoundWithID:(NSUInteger)soundID;	//id is the index in the sound filename array
@end
