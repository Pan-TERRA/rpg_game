  //
  //  RPGBattleViewController.m
  //  RPG Game
  //
  //  Created by Владислав Крут on 10/10/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGBattleViewController.h"
  // API
#import "RPGBattleController+RPGBattlePresentationController.h"
#import "RPGBattleFactoryProtocol.h"
#import "SRWebSocket.h"
  // Controllers
#import "RPGSkillBarViewController.h"
#import "UIViewController+RPGChildViewController.h"
#import "RPGEntityViewController.h"
#import "RPGRewardViewController.h"
#import "RPGBattleTimerViewController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGPlayer.h"
#import "RPGResources.h"
#import "RPGBattleInitResponse.h"
  // Views
#import "RPGProgressBarView.h"
#import "RPGBattleLogViewController.h"
#import "RPGQuickSettingsViewController.h"
#import "RPGWaitingViewController.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGBackgroundMusicController.h"
#import "UIViewController+RPGChildViewController.h"
  // Constants
#import "RPGNibNames.h"

static NSString * const kRPGBattleViewControllerMyTurn = @"My turn";
static NSString * const kRPGBattleViewControllerNotMyTurn = @"Opponent turn";

@interface RPGBattleViewController () <RPGRewardModalDelegate>

@property (nonatomic, assign, readwrite) id<RPGBattleFactoryProtocol> battleFactory;
@property (nonatomic, retain, readwrite) RPGBattleController *battleController;
  // Player
@property (nonatomic, assign, readwrite) IBOutlet UIView *playerViewContainer;
@property (nonatomic, retain, readwrite) RPGEntityViewController *playerViewController;
@property (nonatomic, assign, readwrite) IBOutlet UIView *currentWinCountBadgeViewContainer;
  // Opponent
@property (nonatomic, assign, readwrite) IBOutlet UIView *opponentViewContainer;
@property (nonatomic, retain, readwrite) RPGEntityViewController *opponentViewController;
  // Battle log
@property (nonatomic, retain, readwrite) RPGBattleLogViewController *battleLogViewController;
@property (nonatomic, assign, readwrite) IBOutlet UITextView *battleTextView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *turnLabel;
  // Timer
@property (nonatomic, assign, readwrite) RPGBattleTimerViewController *timerViewController;
@property (nonatomic, retain, readwrite) IBOutlet UIView *timerContainer;
  // Reward
@property (nonatomic, retain, readwrite) RPGRewardViewController *battleRewardViewController;
  // Modals
@property (nonatomic, retain, readwrite) RPGWaitingViewController *battleInitModal;
  // Skill bar
@property (nonatomic, retain, readwrite) RPGSkillBarViewController *skillBarViewController;
@property (nonatomic, assign, readwrite) IBOutlet UIView *skillBar;
  // Settings
@property (nonatomic, retain, readwrite) RPGQuickSettingsViewController *settingsViewController;
@property (nonatomic, assign, readwrite) UIView *settingsView;

@end

@implementation RPGBattleViewController

#pragma mark - Init

- (instancetype)initWithBattleFactory:(id<RPGBattleFactoryProtocol>)aBattleFactory
{
  self = [super initWithNibName:kRPGBattleViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = [aBattleFactory.battleController retain];
    
    _timerViewController = [[RPGBattleTimerViewController alloc] initWithBattleController:_battleController
                                                                             turnDuration:kRPGBattleTurnDuration];
    [_timerViewController registerTimerObservationKeyPath:@"battle.currentTurn"];
    
    if (_battleController != nil)
    {
        // internal view controllers
      _battleRewardViewController = [aBattleFactory.rewardViewController retain];
      _battleRewardViewController.delegate = self;
      
      _battleLogViewController = [[RPGBattleLogViewController alloc] initWithBattleController:_battleController];
      _skillBarViewController = [[RPGSkillBarViewController alloc] initWithBattleController:_battleController];
      
        // player view controller
      _playerViewController = [[RPGEntityViewController alloc] initWithAlign:kRPGAlignLeft];
      
        // opponent view controller
      _opponentViewController = [[RPGEntityViewController alloc] initWithAlign:kRPGAlignRight];
      
      
      _battleInitModal = [aBattleFactory.battleInitViewController retain];
      _battleInitModal.completionHandler = ^
      {
        [self.battleController prepareBattleControllerForDismiss];
        [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
      };
      
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(modelDidChange:)
                                                   name:kRPGModelDidChangeNotification
                                                 object:_battleController];
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(battleInitDidEndSetUp:)
                                                   name:kRPGBattleInitDidEndSetUpNotification
                                                 object:_battleController];
      [[NSNotificationCenter defaultCenter] addObserver:_skillBarViewController
                                               selector:@selector(battleInitDidEndSetUp:)
                                                   name:kRPGBattleInitDidEndSetUpNotification
                                                 object:_battleController];
    }
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [[NSNotificationCenter defaultCenter] removeObserver:_skillBar];
  
  [_battleController release];
  [_playerViewController release];
  [_opponentViewController release];
  [_battleLogViewController release];
  [_timerViewController release];
  [_battleRewardViewController release];
  [_battleInitModal release];
  [_skillBarViewController release];
  [_settingsViewController release];
  
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.battleLogViewController.view = self.battleTextView;
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToBattle];
  
  [self addChildViewController:self.timerViewController
                          view:self.timerContainer];
  [self addChildViewController:self.battleInitModal
                          view:self.view];
  [self addChildViewController:self.skillBarViewController
                          view:self.skillBar];
  [self addChildViewController:self.playerViewController
                          view:self.playerViewContainer];
  [self addChildViewController:self.opponentViewController
                          view:self.opponentViewContainer];
  
  [self.battleController fireUpBattleController];
}

- (void)viewWillAppear:(BOOL)anAnimated
{
  [super viewWillAppear:anAnimated];
}

- (void)viewDidAppear:(BOOL)anAnimated
{
  [super viewDidAppear:anAnimated];
}

- (void)viewWillDisappear:(BOOL)anAnimated
{
  [super viewWillDisappear:anAnimated];
}

- (void)viewDidDisappear:(BOOL)anAnimated
{
    // TODO: if we end battle, we may want to invalidate this timer earlier
    //[self.timer invalidate];
  [super viewDidDisappear:anAnimated];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - Action

- (IBAction)back:(id)aSender
{
  [self.battleController prepareBattleControllerForDismiss];
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
  [self dismissViewControllerAnimated:YES
                           completion:nil];
}

- (IBAction)showSettingsModal:(UIButton *)aSender
{
  if (self.settingsViewController == nil)
  {
    self.settingsViewController = [[[RPGQuickSettingsViewController alloc] init] autorelease];
  }
  
  self.settingsView = self.settingsViewController.view;
  self.settingsView.frame = self.view.frame;
  [self.view addSubview:self.settingsView];
}

  // TODO: move this to appropriate category over UIViewController
- (void)rpg_removeChildViewController:(UIViewController *)aChildViewController
{
  [aChildViewController.view removeFromSuperview];
  [aChildViewController removeFromParentViewController];
}

- (void)removeBattleInitModal
{
  [self.timerViewController restartTimer];
  [self.battleInitModal.view removeFromSuperview];
  [self.battleInitModal removeFromParentViewController];
}

- (void)setUpEntityViewControllers
{
  self.playerViewController.entity = self.battleController.battle.player;
  self.opponentViewController.entity = self.battleController.battle.opponent;
}

#pragma mark - Notifications

- (void)modelDidChange:(NSNotification *)aNotification
{
  RPGBattleController *battleController = self.battleController;
  
  [self.playerViewController updateView];
  [self.opponentViewController updateView];
  
  if (battleController.isMyTurn)
  {
    self.turnLabel.text = kRPGBattleViewControllerMyTurn;
  }
  else
  {
    self.turnLabel.text = kRPGBattleViewControllerNotMyTurn;
  }
  
    // fight end
  if (battleController.battleStatus != kRPGBattleStatusBattleInProgress)
  {
    [self addChildViewController:self.battleRewardViewController frame:self.view.frame];
    [self.battleRewardViewController updateView];
    
    [self.timerViewController invalidateTimer];
    [self.battleController prepareBattleControllerForDismissWithCompletionHandler:^
    {
      dispatch_async(dispatch_get_main_queue(), ^
      {
        self.battleRewardViewController.restartButton.enabled = YES;
      });
    }];
  }
  
    // skillbar
  if (battleController.isMyTurn)
  {
    [self.skillBarViewController updateButtonsState];
  }
}

- (void)battleInitDidEndSetUp:(NSNotification *)aNotification
{
  [self removeBattleInitModal];
  [self setUpEntityViewControllers];
}

#pragma mark - RPGRewardModalDelegate

- (void)dismissRewardModal:(RPGRewardViewController *)aRewardModal
{
  [self.skillBarViewController lockSkillBar];
  
  [aRewardModal.view removeFromSuperview];
  [aRewardModal removeFromParentViewController];
}

- (void)restartBattle:(RPGRewardViewController *)aRewardModal
{
  [self rpg_removeChildViewController:aRewardModal];
  [self addChildViewController:self.battleInitModal view:self.view];
  
  [self.battleController fireUpBattleController];
}

@end
