//
//  RPGsfxEngine.m
//  RPG Game
//
//  Created by Владислав Крут on 10/14/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGsfxEngine.h"
#import "CMOpenALSoundManager.h"
  // Misc
#import "NSUserDefaults+RPGVolumeSettings.h"

static RPGSFXEngine *sharedSFXEngine = nil;

NSString * const kRPGSoundName = @"soundName";

@interface RPGSFXEngine ()

@property (nonatomic, retain, readwrite) CMOpenALSoundManager *soundManager;

@end

@implementation RPGSFXEngine

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self)
  {
      _soundManager = [CMOpenALSoundManager new];
      _playing = [NSUserDefaults standardUserDefaults].soundsPlaying;
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
        if(sharedSFXEngine == nil)
        {
          sharedSFXEngine = [[super allocWithZone:NULL] init];
          double startVolume = [NSUserDefaults standardUserDefaults].soundsVolume;
          sharedSFXEngine.volume = startVolume;
        }
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

#pragma mark - Accessors

- (void)setVolume:(double)aVolume
{
  self.soundManager.soundEffectsVolume = aVolume;
  [NSUserDefaults standardUserDefaults].soundsVolume = aVolume;
}

- (double)volume
{
  return self.soundManager.soundEffectsVolume;
}

- (void)setPlaying:(BOOL)isPlaying
{
  _playing = isPlaying;
  [NSUserDefaults standardUserDefaults].soundsPlaying = isPlaying;
}

#pragma mark - Actions

- (void)playSFXNamed:(NSString *)aName
{
  if (self.isPlaying)
  {
      //TODO: remove hardcode
    NSString *pathToSound = [NSString stringWithFormat:@"Sounds.bundle/SFX/%@.wav", aName];
    self.soundManager.soundFileNames = [NSArray arrayWithObject:pathToSound];
    [self.soundManager playSoundWithID:0];
  }
}

- (void)playSFXWithSkillID:(NSUInteger)aSkillID
{
    //TODO: remove hardcode
  NSString *path = [[NSBundle mainBundle] pathForResource:@"RPGSkillsInfo" ofType:@"plist"];
  NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
  NSDictionary *skillDictionary = [plistDictionary valueForKey:[@(aSkillID) stringValue]];
  
  NSString *soundName = skillDictionary[kRPGSoundName];

  [self playSFXNamed:soundName];
}

@end
