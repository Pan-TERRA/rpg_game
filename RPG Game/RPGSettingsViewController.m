//
//  RPGSettingsViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSettingsViewController.h"
#import "RPGMainViewController.h"

@interface RPGSettingsViewController ()

@property (nonatomic) NSUInteger music;
@property (nonatomic) NSUInteger sounds;


@property (assign, nonatomic) IBOutlet UILabel *musicLabel;
@property (assign, nonatomic) IBOutlet UILabel *soundsLabel;

@property (assign, nonatomic) IBOutlet UIStepper *musicStepper;
@property (assign, nonatomic) IBOutlet UIStepper *soundsStepper;


@end

@implementation RPGSettingsViewController

#pragma mark - Event Handling

- (IBAction)musicChanged:(id)sender
{
    self.music = self.musicStepper.value;
    self.musicLabel.text = [NSString stringWithFormat:@"%lu", (NSUInteger) self.musicStepper.value];
}

- (IBAction)soundsChanged:(id)sender
{
    self.sounds = self.soundsStepper.value;
    self.soundsLabel.text = [NSString stringWithFormat:@"%lu", (NSUInteger) self.soundsStepper.value];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.music = 4;
    self.sounds = 8;
    
    self.musicStepper.value = self.music;
    self.soundsStepper.value = self.sounds;
    
    self.musicLabel.text = [NSString stringWithFormat:@"%lu", (NSUInteger) self.musicStepper.value];
    self.soundsLabel.text = [NSString stringWithFormat:@"%lu", (NSUInteger) self.soundsStepper.value];
    
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
