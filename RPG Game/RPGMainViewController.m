//
//  RPGMainViewController.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGMainViewController.h"

#import "RPGBattleViewController.h"
#import "RPGSettingsViewController.h"
#import "RPGQuestListViewController.h"

#import "NibNames.h"

@interface RPGMainViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *goldImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *crystalsImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsLabel;

@end

@implementation RPGMainViewController

#pragma mark - EventHandling

- (IBAction)segueToQuests
{
    RPGQuestListViewController *questListViewController = [[[RPGQuestListViewController alloc] initWithNibName:kRPGQuestListViewController bundle:nil] autorelease];
    [self presentViewController:questListViewController animated:YES completion:nil];
}

- (IBAction)segueToShop
{
    
}

- (IBAction)segueToChar
{
    
}

- (IBAction)segueToPlay
{
    
}

- (IBAction)segueToAdventures
{
    RPGBattleViewController *battleViewController = [[[RPGBattleViewController alloc] initWithNibName:kRPGBattleViewController bundle:nil] autorelease];
    [self presentViewController:battleViewController animated:YES completion:nil];
}


- (IBAction)segueToArena
{
    
}

- (IBAction)segueToSettings
{
    RPGSettingsViewController *settingsViewController = [[[RPGSettingsViewController alloc] initWithNibName:kRPGSettingsViewController bundle:nil] autorelease];
    [self presentViewController:settingsViewController animated:YES completion:nil];
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
