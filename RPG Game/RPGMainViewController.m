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
#import "RPGSFXEngine.h"
#import "RPGNibNames.h"
#import "NSUserDefaults+RPGSessionInfo.h"

@interface RPGMainViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *goldImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *crystalsImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsLabel;

@end

@implementation RPGMainViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGMainView
                         bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  //set images to money image views
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
  self.goldLabel.text = [NSString stringWithFormat:@"%ld", [standartUserDefaults sessionGold]];
  self.crystalsLabel.text = [NSString stringWithFormat:@"%ld", [standartUserDefaults sessionCrystals]];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  
}

#pragma mark - IBActions

- (IBAction)segueToQuests
{
  RPGQuestListViewController *questListViewController = [[[RPGQuestListViewController alloc] init] autorelease];
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
  RPGBattleViewController *battleViewController = [[[RPGBattleViewController alloc] init] autorelease];
  [self presentViewController:battleViewController animated:YES completion:nil];
}

- (IBAction)segueToArena
{
  
}

- (IBAction)segueToSettings
{
  RPGSettingsViewController *settingsViewController = [[[RPGSettingsViewController alloc] init] autorelease];
  [self presentViewController:settingsViewController animated:YES completion:nil];
}

@end
