//
//  RPGBackgroundMusicController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/13/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBackgroundMusicController.h"
  // Misc
#import "NSUserDefaults+RPGVolumeSettings.h"

static RPGBackgroundMusicController *sharedBackgroundMusicController = nil;

static NSString * const sRPGBundlePath = @"Sounds.bundle/BackGround/";
static NSString * const sRPGPeaceMusicName = @"PeaceMusic.wav";
static NSString * const sRPGBattleMusicName = @"BattleMusic.wav";

@interface RPGBackgroundMusicController ()

@property (nonatomic, retain, readwrite) AVAudioPlayer *peacePlayer;
@property (nonatomic, retain, readwrite) AVAudioPlayer *battlePlayer;
@property (nonatomic, assign, readwrite) AVAudioPlayer *currentPlayer;

@end

@implementation RPGBackgroundMusicController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self)
  {
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *peaceMusicPath = [NSString stringWithFormat:@"%@%@", sRPGBundlePath, sRPGPeaceMusicName];
    NSString *absolutePeaceMusicPath = [bundlePath stringByAppendingPathComponent:peaceMusicPath];
    
    NSURL *peaceMusic = [[[NSURL alloc] initFileURLWithPath:absolutePeaceMusicPath] autorelease];
    _peacePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:peaceMusic error:nil];
    
    _peacePlayer.numberOfLoops = -1;
    _peacePlayer.delegate = self;
    
    NSString *battleMusicPath = [NSString stringWithFormat:@"%@%@", sRPGBundlePath, sRPGBattleMusicName];
    NSString *absoluteBattleMusicPath = [bundlePath stringByAppendingPathComponent:battleMusicPath];
    
    NSURL *battleMusic = [[[NSURL alloc] initFileURLWithPath:absoluteBattleMusicPath] autorelease];
    _battlePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:battleMusic error:nil];
    
    _battlePlayer.numberOfLoops = -1;
    _battlePlayer.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(interruption:)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:nil];
    NSError *setCategoryError = nil;
    
    if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError])
    {
      NSLog(@"Error setting category! %@", setCategoryError);
    }
    
    self.playing = [[NSUserDefaults standardUserDefaults] isMusicPlaying];
	[[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    [self switchToPeace];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_peacePlayer release];
  [_battlePlayer release];
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
      double startVolume = [NSUserDefaults standardUserDefaults].musicVolume;
      sharedBackgroundMusicController.volume = startVolume;
    }
  }
  return sharedBackgroundMusicController;
}

+ (id)allocWithZone:(NSZone *)aZone
{
  return [[self sharedBackgroundMusicController] retain];
}

- (id)copyWithZone:(NSZone *)aZone
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
  self.peacePlayer.volume = aVolume;
  self.battlePlayer.volume = aVolume;
  [NSUserDefaults standardUserDefaults].musicVolume = aVolume;
}

- (double)volume
{
  return self.peacePlayer.volume;
}

- (void)setPlaying:(BOOL)isPlaying
{
  _playing = isPlaying;
  [NSUserDefaults standardUserDefaults].musicPlaying = isPlaying;
  if (_playing)
  {
    [self.currentPlayer play];
  }
  else
  {
    [self.peacePlayer pause];
    [self.battlePlayer pause];
  }
  
}

#pragma mark - Music Changing

- (void)switchToBattle
{
  self.currentPlayer = self.battlePlayer;
  if (self.playing)
  {
    [self.peacePlayer pause];
    [self.battlePlayer play];

  }
}

- (void)switchToPeace
{
  self.currentPlayer = self.peacePlayer;
  if (self.playing)
  {
    [self.battlePlayer pause];
    [self.peacePlayer play];
  }
}

#pragma mark - AudioSession Delegate

- (void)interruption:(NSNotification*)aNotification
{
  NSDictionary *interuptionDict = aNotification.userInfo;
  
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
