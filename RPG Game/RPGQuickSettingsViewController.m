//
//  RPGQuickSettingsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuickSettingsViewController.h"
  // Misc
#import "RPGBackgroundMusicController.h"
#import "RPGSFXEngine.h"

@interface RPGQuickSettingsViewController ()

@property (retain, nonatomic) IBOutlet UISlider *musicVolumeSlider;
@property (retain, nonatomic) IBOutlet UISlider *soundVolumeSlider;
@property (retain, nonatomic) IBOutlet UISwitch *musicSwitch;
@property (retain, nonatomic) IBOutlet UISwitch *soundSwitch;

@end

@implementation RPGQuickSettingsViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:@"RPGQuickSettingsViewController" bundle:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - IBActions

- (IBAction)musicTurn:(UISwitch *)aSender
{
  [RPGBackgroundMusicController sharedBackgroundMusicController].playing = aSender.on;
}

- (IBAction)musicVolumeChange:(UISlider *)aSender
{
  [RPGBackgroundMusicController sharedBackgroundMusicController].volume = aSender.value;
}

- (IBAction)soundTurn:(UISwitch *)aSender
{
  [RPGSFXEngine sharedSFXEngine].playing = aSender.on;
}

- (IBAction)soundVolumeChange:(UISlider *)aSender
{
  [RPGSFXEngine sharedSFXEngine].volume = aSender.value;
}

- (IBAction)back:(UIButton *)sender
{
  [self.view removeFromSuperview];
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


@end
