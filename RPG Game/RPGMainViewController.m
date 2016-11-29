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
#import "RPGAdventuresController.h"
#import "RPGArenaController.h"
  // Views
#import "RPGSettingsViewController.h"
#import "RPGQuestListViewController.h"
#import "RPGCharacterProfileViewController.h"
#import "RPGArenaSkillDrawViewController.h"
#import "RPGBattlePresentingViewControllerProtocol.h"
  // Misc
#import "RPGSFXEngine.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"

#import "RPGNetworkManager.h"
#import "RPGResources.h"

@interface RPGMainViewController () <RPGBattlePresentingViewController>

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

- (void)restartBattle:(RPGBattleViewController *)battleViewController
{
  [self dismissViewControllerAnimated:YES completion:^
  {
    RPGBattleController *battleController = battleViewController.battleController;
    if ([battleController isMemberOfClass:[RPGAdventuresController class]])
    {
      [self segueToAdventures];
    }
    else if ([battleController isMemberOfClass:[RPGArenaController class]])
    {
      [self segueToArena];
    }
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
  RPGBattleControllerGenerator *adventuresControllerGenerator = [[[RPGAdventuresControllerGenerator alloc] init] autorelease];
  RPGBattleViewController *battleViewController = [[[RPGBattleViewController alloc] initWithBattleControllerGenerator:adventuresControllerGenerator] autorelease];
  battleViewController.delegate = self;
  
  [self presentViewController:battleViewController
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
