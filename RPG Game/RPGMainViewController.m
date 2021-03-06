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
#import "RPGAdventureGlobalMapViewController.h"
#import "RPGArenaController.h"
#import "RPGTournamentController.h"
  // Views
#import "RPGBattleViewController.h"
#import "RPGSettingsViewController.h"
#import "RPGQuestListViewController.h"
#import "RPGCharacterProfileViewController.h"
#import "RPGShopViewController.h"
#import "RPGArenaSkillDrawViewController.h"
#import "RPGFriendsViewController.h"
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
#import "RPGDuelCountResponse.h"

static CGFloat const kRPGMainViewControllerViewCornerRadiusMultiplier = 0.5;

@interface RPGMainViewController () <RPGPresentingViewController>

@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIView *duelQuestsCountView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *duelQuestsCountLabel;

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
  
  self.duelQuestsCountView.layer.cornerRadius = self.duelQuestsCountView.frame.size.height * kRPGMainViewControllerViewCornerRadiusMultiplier;
  self.duelQuestsCountView.layer.masksToBounds = YES;
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
  
  [[RPGNetworkManager sharedNetworkManager] getDuelQuestsCountWithCompletionHandler:^(RPGStatusCode aNetworkStatusCode, RPGDuelCountResponse * aResponse)
  {
    if (aNetworkStatusCode == kRPGStatusCodeOK)
    {
      NSInteger count = aResponse.duelQuestsCount;
      self.duelQuestsCountLabel.text = [NSString stringWithFormat:@"%ld", (long)count];
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

- (IBAction)segueToDuelQuests
{
  RPGQuestListViewController *questListViewController = [[[RPGQuestListViewController alloc] initWithType:kRPGQuestTypeDuel] autorelease];
  
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

- (IBAction)segueToTournament
{
  RPGTournamentFactory *tournamentFactory = [[[RPGTournamentFactory alloc] init] autorelease];
  RPGTournamentViewController *tournamentViewController = [[[RPGTournamentViewController alloc]
                                                            initWithBattleFactory:tournamentFactory]
                                                           autorelease];
  
  [self presentViewController:tournamentViewController animated:YES completion:nil];
}

- (IBAction)segueToFriends
{
  RPGFriendsViewController *friendsViewController = [[RPGFriendsViewController new] autorelease];
  
  [self presentViewController:friendsViewController animated:YES completion:nil];
}

- (IBAction)segueToAdventures
{
  [self presentViewController:[[[RPGAdventureGlobalMapViewController alloc] init] autorelease]
                     animated:YES
                   completion:nil];
}

- (IBAction)segueToArena
{
  RPGArenaSkillDrawViewController *arenaViewController = [[[RPGArenaSkillDrawViewController alloc] init] autorelease];
  arenaViewController.delegate = self;
  
  [self presentViewController:arenaViewController
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
