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
  // Controllers
#import "RPGArenaControllerGenerator.h"
#import "RPGAdventuresControllerGenerator.h"
#import "RPGAdventureGlobalMapViewController.h"
  // Views
#import "RPGSettingsViewController.h"
#import "RPGQuestListViewController.h"
#import "RPGCharacterProfileViewController.h"
#import "RPGArenaSkillDrawViewController.h"
  // Misc
#import "RPGSFXEngine.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"

#import "RPGNetworkManager.h"
#import "RPGResources.h"

@interface RPGMainViewController () <RPGPresentingViewController>

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
  [self updateResourcesLabels];
  
  [[RPGNetworkManager sharedNetworkManager] getResourcesWithCompletionHandler:^(NSInteger aStatusCode, RPGResources *aResources)
  {
    if (aStatusCode == 0)
    {
      NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
      standartUserDefaults.sessionGold = aResources.gold;
      standartUserDefaults.sessionCrystals = aResources.crystals;
      [self updateResourcesLabels];
    }
  }];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - RPGPresentingViewController

- (void)dismissCurrentAndPresentViewController:(UIViewController *)aViewController
{
  [self dismissViewControllerAnimated:NO completion:^
  {
    [self presentViewController:aViewController animated:YES completion:nil];
  }];
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
  RPGCharacterProfileViewController *characterProfileViewController = [[[RPGCharacterProfileViewController alloc] init] autorelease];
  
  [self presentViewController:characterProfileViewController animated:YES completion:nil];
}

- (IBAction)segueToPlay
{
  
}

- (IBAction)segueToAdventures
{
  RPGAdventureGlobalMapViewController *adventureGlobalMapViewController = [[RPGAdventureGlobalMapViewController alloc] init];
  [self presentViewController:[adventureGlobalMapViewController autorelease]
                     animated:YES
                   completion:nil];
}

- (IBAction)segueToArena
{
  RPGArenaSkillDrawViewController *viewController = [[[RPGArenaSkillDrawViewController alloc] init] autorelease];
  viewController.delegate = self;
  [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)segueToSettings
{
  RPGSettingsViewController *settingsViewController = [[[RPGSettingsViewController alloc] init] autorelease];
  [self presentViewController:settingsViewController animated:YES completion:nil];
}

- (void)updateResourcesLabels
{
  NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
  self.goldLabel.text = [NSString stringWithFormat:@"%ld", (long)standartUserDefaults.sessionGold];
  self.crystalsLabel.text = [NSString stringWithFormat:@"%ld", (long)standartUserDefaults.sessionCrystals];
}

@end
