//
//  RPGSettingsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSettingsViewController.h"
#import "RPGBackgroundMusicController.h"
#import "RPGNetworkManager+Authorization.h"
#import "RPGSFXEngine.h"
#import "RPGNibNames.h"
#import "NSUserDefaults+RPGVolumeSettings.h"
#import "RPGStatusCodes.h"
#import "RPGAlert.h"

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
  self.musicSwitch.on = [RPGBackgroundMusicController sharedBackgroundMusicController].isPlaying;
  self.musicVolumeSlider.value = [[RPGBackgroundMusicController sharedBackgroundMusicController] getVolume];
  
  self.soundSwitch.on = [RPGSFXEngine sharedSFXEngine].isPlaying;
  self.soundVolumeSlider.value = [[RPGSFXEngine sharedSFXEngine] getVolume];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
  {
    mask = UIInterfaceOrientationMaskLandscape;
  }
  return mask;
}

#pragma mark - Event Handling

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
       case kRPGStatusCodeOK:
         
         break;
         
       case kRPGStatusCodeWrongJSON:
         NSLog(@"Logout: wrongJSON");
         break;
         
       default:
         break;
     }
   }];
  
  [RPGAlert showAlertViewControllerWithTitle:@"Log out" message:@"Success" viewController:self completion:^(void){
    UIViewController *viewController = self.presentingViewController.presentingViewController;
    [viewController dismissViewControllerAnimated:YES completion:nil];
  }];
}

- (IBAction)musicTurn:(UISwitch *)aSender
{
  [[RPGBackgroundMusicController sharedBackgroundMusicController] toggle:aSender.on];
  BOOL isMusicPlaying = [[RPGBackgroundMusicController sharedBackgroundMusicController] isPlaying];
  [[NSUserDefaults standardUserDefaults] setIsMusicPlaying:isMusicPlaying];
}

- (IBAction)musicVolumeChange:(UISlider *)aSender
{
  [[RPGBackgroundMusicController sharedBackgroundMusicController] changeVolume:aSender.value];
  double musicVolume = [[RPGBackgroundMusicController sharedBackgroundMusicController] getVolume];
  [[NSUserDefaults standardUserDefaults] setMusicVolume:musicVolume];
}

- (IBAction)soundTurn:(UISwitch *)aSender
{
  [[RPGSFXEngine sharedSFXEngine] toggle:aSender.on];
  BOOL isSoundsPlaying = [[RPGSFXEngine sharedSFXEngine] isPlaying];
  [[NSUserDefaults standardUserDefaults] setIsSoundsPlaying:isSoundsPlaying];
}

- (IBAction)soundVolumeChange:(UISlider *)aSender
{
  [[RPGSFXEngine sharedSFXEngine] changeVolume:aSender.value];
  double soundsVolume = [[RPGSFXEngine sharedSFXEngine] getVolume];
  [[NSUserDefaults standardUserDefaults] setSoundsVolume:soundsVolume];
}

@end
