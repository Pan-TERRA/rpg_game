//
//  RPGSettingsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSettingsViewController.h"
#import "RPGBackgroundMusicController.h"

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
    sender.state ? NSLog(@"Sound On") : NSLog(@"Sound Off");
}

- (IBAction)soundVolumeChange:(UISlider *)sender
{
    NSLog(@"Sound Volume = %f", sender.value);
}


#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
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
