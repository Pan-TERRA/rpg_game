//
//  RPGSettingsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSettingsViewController.h"
#import "RPGNetworkManager+Authorization.h"

#import "RPGBackgroundMusicController.h"
#import "RPGSFXEngine.h"

@interface RPGSettingsViewController ()

@property (assign, nonatomic) IBOutlet UISwitch *musicSwitch;
@property (assign, nonatomic) IBOutlet UISlider *musicVolumeSlider;

@property (assign, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (assign, nonatomic) IBOutlet UISlider *soundVolumeSlider;

@end

@implementation RPGSettingsViewController

#pragma mark - Event Handling

- (IBAction)back:(id)sender
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

- (IBAction)musicTurn:(UISwitch *)sender
{
    [[RPGBackgroundMusicController sharedBackgroundMusicController] toggle:sender.on];
}

- (IBAction)musicVolumeChange:(UISlider *)sender
{
	[[RPGBackgroundMusicController sharedBackgroundMusicController] changeVolume:sender.value];
}

- (IBAction)soundTurn:(UISwitch *)sender
{
    [[RPGSFXEngine sharedSFXEngine] toggle:sender.on];
}

- (IBAction)soundVolumeChange:(UISlider *)sender
{
    [[RPGSFXEngine sharedSFXEngine] changeVolume:sender.value];
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

- (void)dealloc
{
    [super dealloc];
}

@end
