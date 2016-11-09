  //
  //  RPGMainViewController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/10/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGMainViewController.h"
  // API
#import "RPGBattleViewController.h"
  // Views
#import "RPGSettingsViewController.h"
#import "RPGQuestListViewController.h"
  // Misc
#import "RPGSFXEngine.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"

#import "RPGNetworkManager.h"
#import "RPGResources.h"

@interface RPGMainViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsLabel;

@end

@implementation RPGMainViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGMainViewNIBName
                         bundle:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
  
  [[RPGNetworkManager sharedNetworkManager] getResourcesWithCompletionHandler:^(NSInteger aStatusCode, RPGResources *aResources) {
    NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
    if (aStatusCode == 0)
    {
      standartUserDefaults.sessionGold = aResources.gold;
      standartUserDefaults.sessionCrystals = aResources.crystals;
    }
    self.goldLabel.text = [NSString stringWithFormat:@"%ld", standartUserDefaults.sessionGold];
    self.crystalsLabel.text = [NSString stringWithFormat:@"%ld", standartUserDefaults.sessionCrystals];
  }];
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
  [self presentViewController:[[[RPGBattleViewController alloc] init] autorelease]
                     animated:YES
                   completion:nil];
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
