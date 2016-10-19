//
//  RPGBattleViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleViewController.h"
#import "RPGBackgroundMusicController.h"
#import "RPGSFXEngine.h"

@interface RPGBattleViewController ()

@property (assign, nonatomic) IBOutlet UILabel *player1NickName;
@property (assign, nonatomic) IBOutlet UILabel *player2NickName;

@property (assign, nonatomic) IBOutlet UILabel *player1hp;
@property (assign, nonatomic) IBOutlet UILabel *player2hp;

@property (assign, nonatomic) IBOutlet UIProgressView *player1hpBar;
@property (assign, nonatomic) IBOutlet UIProgressView *player2hpBar;

@property (assign, nonatomic) IBOutlet UITextView *battleTextView;

@property (assign, nonatomic) IBOutlet UIButton *spell1Button;
@property (assign, nonatomic) IBOutlet UIButton *spell2Button;
@property (assign, nonatomic) IBOutlet UIButton *spell3Button;
@property (assign, nonatomic) IBOutlet UIButton *spell4Button;
@property (assign, nonatomic) IBOutlet UIButton *spell5Button;
@property (assign, nonatomic) IBOutlet UIButton *spell6Button;
@property (assign, nonatomic) IBOutlet UIButton *spell7Button;

@property (assign, nonatomic) IBOutlet UILabel *timer;

@end

@implementation RPGBattleViewController


#pragma mark - EventHandling

- (IBAction)back:(id)sender
{
    [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Spell Actions
- (IBAction)spell1_action:(id)sender
{
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:1];
}

- (IBAction)spell2_action:(id)sender
{
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:2];
}

- (IBAction)spell3_action:(id)sender
{
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:3];
}

- (IBAction)spell4_action:(id)sender
{
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:4];
}

- (IBAction)spell5_action:(id)sender
{
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:5];
}

- (IBAction)spell6_action:(id)sender
{
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:6];
}

- (IBAction)spell7_action:(id)sender
{
    [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:7];
}

#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToBattle];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
