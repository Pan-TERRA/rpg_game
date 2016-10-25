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
  return [super initWithNibName:kRPGSettingsViewController
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
     NSString *message = (status == 0 ? @"Ok" : @"Something went wrong. Try to delete your iOS and install a new one");
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log out" message:message preferredStyle:UIAlertControllerStyleAlert];
     [self presentViewController:alert animated:YES completion:nil];
   }];
}

- (IBAction)musicTurn:(UISwitch *)aSender
{
  [[RPGBackgroundMusicController sharedBackgroundMusicController] toggle:aSender.on];
}

- (IBAction)musicVolumeChange:(UISlider *)aSender
{
  [[RPGBackgroundMusicController sharedBackgroundMusicController] changeVolume:aSender.value];
}

- (IBAction)soundTurn:(UISwitch *)aSender
{
  [[RPGSFXEngine sharedSFXEngine] toggle:aSender.on];
}

- (IBAction)soundVolumeChange:(UISlider *)aSender
{
  [[RPGSFXEngine sharedSFXEngine] changeVolume:aSender.value];
}

@end
