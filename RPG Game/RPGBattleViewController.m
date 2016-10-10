//
//  RPGBattleViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleViewController.h"

@interface RPGBattleViewController ()

//@property (retain, nonatomic) RPGPlayer *player1;
//@property (retain, nonatomic) RPGPlayer *player2;

@property (retain, nonatomic) IBOutlet UILabel *player1Level;
@property (retain, nonatomic) IBOutlet UILabel *player2Level;

@property (retain, nonatomic) IBOutlet UILabel *player1NickName;
@property (retain, nonatomic) IBOutlet UILabel *player2NickName;

@property (retain, nonatomic) IBOutlet UILabel *player1hp;
@property (retain, nonatomic) IBOutlet UILabel *player2hp;

@property (retain, nonatomic) IBOutlet UIProgressView *player1hpBar;
@property (retain, nonatomic) IBOutlet UIProgressView *player2hpBar;

@property (retain, nonatomic) IBOutlet UITextView *battleTextView;

@property (retain, nonatomic) IBOutlet UIButton *spell1Button;
@property (retain, nonatomic) IBOutlet UIButton *spell2Button;
@property (retain, nonatomic) IBOutlet UIButton *spell3Button;

@property (retain, nonatomic) IBOutlet UILabel *timer;

@end

@implementation RPGBattleViewController

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [_player1Level release];
    [_player2Level release];
    [_player1NickName release];
    [_player2NickName release];
    [_player1hp release];
    [_player2hp release];
    [_player1hpBar release];
    [_player2hpBar release];
    [_battleTextView release];
    [_spell1Button release];
    [_spell2Button release];
    [_spell3Button release];
    [_timer release];
    [super dealloc];
}
@end
