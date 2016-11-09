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

@property (nonatomic, retain, readwrite) IBOutlet UIViewController *battleInitModal;
@property (nonatomic, retain, readwrite) RPGBattleViewController *battleViewController;

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
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kRPGBattleManagerDidEndSetUpNotification
                                                object:self.battleViewController.battleManager];
  
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
 */
- (void)battleManagerDidEndSetUp:(NSNotification *)aNotification
{
  [self.battleInitModal.view removeFromSuperview];
  [self.battleInitModal removeFromParentViewController];
  
  [self presentViewController:self.battleViewController animated:YES completion:nil];
}
@end
