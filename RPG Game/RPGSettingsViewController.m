//
//  RPGSettingsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSettingsViewController.h"
  // API
#import "RPGNetworkManager+Authorization.h"
  // Misc
#import "RPGBackgroundMusicController.h"
#import "RPGSFXEngine.h"
#import "NSUserDefaults+RPGVolumeSettings.h"
#import "RPGAlert.h"
  // Constants
#import "RPGNibNames.h"
#import "RPGStatusCodes.h"

@interface RPGSettingsViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UISwitch *musicSwitch;
@property (nonatomic, assign, readwrite) IBOutlet UISlider *musicVolumeSlider;
@property (nonatomic, assign, readwrite) IBOutlet UISwitch *soundSwitch;
@property (nonatomic, assign, readwrite) IBOutlet UISlider *soundVolumeSlider;

@end

@implementation RPGSettingsViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGSettingsViewControllerNIBName
                         bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.musicSwitch.on = [RPGBackgroundMusicController sharedBackgroundMusicController].playing;
  self.musicVolumeSlider.value = [RPGBackgroundMusicController sharedBackgroundMusicController].volume;
  
  self.soundSwitch.on = [RPGSFXEngine sharedSFXEngine].playing;
  self.soundVolumeSlider.value = [RPGSFXEngine sharedSFXEngine].volume;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - IBAction

- (IBAction)back:(id)aSender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logOut
{
  RPGNetworkManager *networkManager = [RPGNetworkManager sharedNetworkManager];
  [networkManager logoutWithCompletionHandler:^(NSInteger status)
   {
     switch (status)
     {
      
       case kRPGStatusCodeWrongToken:
       {
         NSLog(@"Logout: wrongJSON");
         break;
       }
         
       case kRPGStatusCodeOK:
       {
         UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
         [rootViewController dismissViewControllerAnimated:YES
                                                completion:nil];
         break;
       }

       case kRPGStatusCodeWrongJSON:
       {
         NSLog(@"Logout: wrongJSON");
         break;
       }
         
       default:
       {
         break;
       }
     }
   }];
}

- (IBAction)musicTurn:(UISwitch *)aSender
{
  [[RPGBackgroundMusicController sharedBackgroundMusicController] toggle:aSender.on];
  BOOL isMusicPlaying = [RPGBackgroundMusicController sharedBackgroundMusicController].playing;
  [NSUserDefaults standardUserDefaults].musicPlaying = isMusicPlaying;
}

- (IBAction)musicVolumeChange:(UISlider *)aSender
{
  [RPGBackgroundMusicController sharedBackgroundMusicController].volume = aSender.value;
  double musicVolume = [RPGBackgroundMusicController sharedBackgroundMusicController].volume;
  [NSUserDefaults standardUserDefaults].musicVolume = musicVolume;
}

- (IBAction)soundTurn:(UISwitch *)aSender
{
  [[RPGSFXEngine sharedSFXEngine] toggle];
  BOOL isSoundsPlaying = [RPGSFXEngine sharedSFXEngine].playing;
  [NSUserDefaults standardUserDefaults].soundsPlaying = isSoundsPlaying;
}

- (IBAction)soundVolumeChange:(UISlider *)aSender
{
  [RPGSFXEngine sharedSFXEngine].volume = aSender.value;
  double soundsVolume = [RPGSFXEngine sharedSFXEngine].volume;
  [NSUserDefaults standardUserDefaults].soundsVolume = soundsVolume;
}

@end
