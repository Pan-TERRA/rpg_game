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
#import "RPGAlertController.h"
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
         [RPGAlertController showAlertWithTitle:@"Error" message:@"Logout: wrongJSON" completion:nil];
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

@end
