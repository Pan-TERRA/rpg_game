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

@property (retain, nonatomic) IBOutlet UIViewController *battleInitModal;
@property (retain, nonatomic) IBOutlet RPGBattleViewController *battleViewController;

@end

@implementation RPGMainViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGMainViewNIBName
                         bundle:nil];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kRPGBattleManagerDidEndSetUpNotification
                                                object:self.battleViewController.battleManager];
  
  [_battleViewController release];
  [_battleInitModal release];
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
    //set images to money image views
 
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
  {
    mask = UIInterfaceOrientationMaskLandscape;
  }
  return mask;
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  
  NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
  self.goldLabel.text = [NSString stringWithFormat:@"%ld", (long)[standartUserDefaults sessionGold]];
  self.crystalsLabel.text = [NSString stringWithFormat:@"%ld", (long)[standartUserDefaults sessionCrystals]];
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
  self.battleViewController = [[[RPGBattleViewController alloc] init] autorelease];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(battleManagerDidEndSetUp:)
                                               name:kRPGBattleManagerDidEndSetUpNotification
                                             object:self.battleViewController.battleManager];
  
  [self addChildViewController:self.battleInitModal];
  self.battleInitModal.view.frame = self.view.frame;
  [self.view addSubview:self.battleInitModal.view];
  [self.battleInitModal didMoveToParentViewController:self];
}

- (IBAction)segueToArena
{
  
}

- (IBAction)segueToSettings
{
  RPGSettingsViewController *settingsViewController = [[[RPGSettingsViewController alloc] init] autorelease];
  [self presentViewController:settingsViewController animated:YES completion:nil];
}

#pragma mark - Notifications

/**
 *  Performs after SRWebSocket receive BATTLE_INIT message
 *
 */
- (void)battleManagerDidEndSetUp:(NSNotification *)aNotification
{
  [self.battleInitModal.view removeFromSuperview];
  [self.battleInitModal removeFromParentViewController];
  
  [self presentViewController:self.battleViewController animated:YES completion:nil];
}
@end
