  //
  //  RPGMainViewController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 10/10/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGMainViewController.h"
  // API
#import "RPGNetworkManager.h"
#import "RPGAdventuresFactory.h"
#import "RPGArenaFactory.h"
#import "RPGTournamentFactory.h"
  // Controllers
#import "RPGAdventuresController.h"
#import "RPGArenaController.h"
#import "RPGTournamentController.h"
  // Views
#import "RPGBattleViewController.h"
#import "RPGSettingsViewController.h"
#import "RPGQuestListViewController.h"
#import "RPGCharacterProfileViewController.h"
#import "RPGShopViewController.h"
#import "RPGArenaSkillDrawViewController.h"
#import "RPGPresentingViewControllerProtocol.h"
#import "RPGTournamentViewController.h"
  // Misc
#import "RPGSFXEngine.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"
  // Entities
#import "RPGResources.h"
#import "RPGResourcesResponse.h"

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
  
  [[RPGNetworkManager sharedNetworkManager] getResourcesWithCompletionHandler:^(RPGStatusCode aNetworkStatusCode,
                                                                                RPGResourcesResponse *aResponse)
  {
    if (aNetworkStatusCode == kRPGStatusCodeOK)
    {
      RPGResources *resources = aResponse.resources;
      NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
      standartUserDefaults.sessionGold = resources.gold;
      standartUserDefaults.sessionCrystals = resources.crystals;
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
  [self dismissViewControllerAnimated:NO
                           completion:^
  {
    [self presentViewController:aViewController
                       animated:YES
                     completion:nil];
  }];
}

#pragma mark - IBActions

- (IBAction)segueToQuests
{
  RPGQuestListViewController *questListViewController = [[[RPGQuestListViewController alloc] init] autorelease];
  
  [self presentViewController:questListViewController
                     animated:YES
                   completion:nil];
}


- (IBAction)segueToShop
{
  RPGShopViewController *shopViewController = [[[RPGShopViewController alloc] init] autorelease];
  
  [self presentViewController:shopViewController
                     animated:YES
                   completion:nil];
}

- (IBAction)segueToChar
{
  RPGCharacterProfileViewController *characterProfileViewController = [[[RPGCharacterProfileViewController alloc] init] autorelease];
  
  [self presentViewController:characterProfileViewController
                     animated:YES
                   completion:nil];
}

- (IBAction)segueToPlay
{
  RPGTournamentFactory *tournamentFactory = [[[RPGTournamentFactory alloc] init] autorelease];
  RPGTournamentViewController *tournamentViewController = [[[RPGTournamentViewController alloc]
                                                            initWithBattleFactory:tournamentFactory]
                                                           autorelease];
  
  [self presentViewController:tournamentViewController animated:YES completion:nil];
}

- (IBAction)segueToAdventures
{
  RPGAdventuresFactory *adventuresFactory = [[[RPGAdventuresFactory alloc] init] autorelease];
  RPGBattleViewController *battleViewController = [[[RPGBattleViewController alloc]
                                                    initWithBattleFactory:adventuresFactory]
                                                   autorelease];
  
  [self presentViewController:battleViewController
                     animated:YES
                   completion:nil];
}

- (IBAction)segueToArena
{
  RPGArenaSkillDrawViewController *viewController = [[[RPGArenaSkillDrawViewController alloc] init] autorelease];
  viewController.delegate = self;
  
  [self presentViewController:viewController
                     animated:YES
                   completion:nil];
}

- (IBAction)segueToSettings
{
  RPGSettingsViewController *settingsViewController = [[[RPGSettingsViewController alloc] init] autorelease];
  
  [self presentViewController:settingsViewController
                     animated:YES
                   completion:nil];
}

- (void)updateResourcesLabels
{
  NSUserDefaults *standartUserDefaults = [NSUserDefaults standardUserDefaults];
  
  self.goldLabel.text = [NSString stringWithFormat:@"%ld", (long)standartUserDefaults.sessionGold];
  self.crystalsLabel.text = [NSString stringWithFormat:@"%ld", (long)standartUserDefaults.sessionCrystals];
}

@end
