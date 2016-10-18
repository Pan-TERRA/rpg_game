//
//  RPGSettingsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSettingsViewController.h"
#import "RPGBackgroundMusicController.h"

#import "RPGSFXEngine.h"

@interface RPGSettingsViewController ()

@property (retain, nonatomic) IBOutlet UISwitch *musicSwitch;
@property (retain, nonatomic) IBOutlet UISlider *musicVolumeSlider;

@property (retain, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (retain, nonatomic) IBOutlet UISlider *soundVolumeSlider;


@end

@implementation RPGSettingsViewController

#pragma mark - Event Handling

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logOut
{
    NSLog(@"LogOut");
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
    self.musicSwitch.on = [RPGBackgroundMusicController sharedBackgroundMusicController].state;
    self.musicVolumeSlider.value = [[RPGBackgroundMusicController sharedBackgroundMusicController] getVolume];
    
    self.soundSwitch.on = [RPGSFXEngine sharedSFXEngine].state;
    self.soundVolumeSlider.value = [[RPGSFXEngine sharedSFXEngine] getVolume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_musicSwitch release];
    [_musicVolumeSlider release];
    [_soundSwitch release];
    [_soundVolumeSlider release];
    [super dealloc];
}
@end
