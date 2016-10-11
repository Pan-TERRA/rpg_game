//
//  RPGBattleViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleViewController.h"

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


@end
