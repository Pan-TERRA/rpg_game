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
#import "RPGArenaController.h"
#import "SRWebSocket.h"
  // Controllers
#import "RPGSkillBarViewController.h"
#import "UIViewController+RPGChildViewController.h"
#import "RPGEntityViewController.h"
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

static int sRPGBattleViewContollerBattleControllerBattleCurrentTurnContext;

static NSString * const kRPGBattleViewControllerMyTurn = @"My turn";
static NSString * const kRPGBattleViewControllerNotMyTurn = @"Opponent turn";

@interface RPGBattleViewController ()

@property (retain, nonatomic, readwrite) RPGBattleControllerGenerator *battleControllerGenerator;
@property (nonatomic, retain, readwrite) RPGBattleController *battleController;
  // Player
@property (assign, nonatomic) IBOutlet UIView *playerViewContainer;
@property (nonatomic, retain, readwrite) RPGEntityViewController *playerViewController;
  // Opponent
@property (assign, nonatomic) IBOutlet UIView *opponentViewContainer;
@property (nonatomic, retain, readwrite) RPGEntityViewController *opponentViewController;
  // Battle log
@property (nonatomic, retain, readwrite) RPGBattleLogViewController *battleLogViewController;
@property (nonatomic, assign, readwrite) IBOutlet UITextView *battleTextView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *turnLabel;
  // Timer
@property (nonatomic, assign, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain, readwrite) NSTimer *timer;
@property (nonatomic, assign, readwrite) NSInteger timerCounter;
  // Reward
@property (nonatomic, retain, readwrite) IBOutlet UIViewController *battleRewardModal;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *winnerNickNameLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardGoldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardCrystalsLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardExpLabel;
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

- (instancetype)initWithBattleControllerGenerator:(RPGBattleControllerGenerator *)aBattleControllerGenerator
{
  self = [super initWithNibName:kRPGBattleViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleControllerGenerator = [aBattleControllerGenerator retain];
    _battleController = [[_battleControllerGenerator battleController] retain];
    
    _timerCounter = kRPGBattleTurnDuration;
    
    if (_battleController != nil)
    {
        // internal view controllers
      _battleLogViewController = [[RPGBattleLogViewController alloc] initWithBattleController:_battleController];
      _skillBarViewController = [[RPGSkillBarViewController alloc] initWithBattleController:_battleController];
      
        // player view controller
      _playerViewController = [[RPGEntityViewController alloc] initWithAlign:kRPGProgressBarLeftAlign];

        // opponent view controller
      _opponentViewController = [[RPGEntityViewController alloc] initWithAlign:kRPGProgressBarRightAlign];

      
      _battleInitModal = [[RPGWaitingViewController alloc] initWithMessage:@"Battle init" completion:^
                          {
                            [self.battleController prepareBattleControllerForDismiss];
                            [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
                          }];
      
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
    
      [_battleController addObserver:self
                          forKeyPath:@"battle.currentTurn"
                             options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                             context:&sRPGBattleViewContollerBattleControllerBattleCurrentTurnContext];
      
      
    }
    
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [[NSNotificationCenter defaultCenter] removeObserver:_skillBar];
  
  [_battleController removeObserver:self
                         forKeyPath:@"battle.currentTurn"
                            context:&sRPGBattleViewContollerBattleControllerBattleCurrentTurnContext];
  
  [_battleInitModal release];
  [_battleLogViewController release];
  [_battleRewardModal release];
  [_battleController release];
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
  
    //show battle init modal
  [self addChildViewController:self.battleInitModal frame:self.view.frame];
  
    //skill bar view
  [self addChildViewController:self.skillBarViewController];
  CGSize size = self.skillBar.frame.size;
  self.skillBarViewController.view.frame = CGRectMake(0, 0, size.width, size.height);
  [self.skillBar addSubview:self.skillBarViewController.view];
  [self.skillBarViewController didMoveToParentViewController:self];
  
    // player view controller set up
  [self addChildViewController:self.playerViewController frame:self.playerViewContainer.frame];
    // opponent view controller set up
  [self addChildViewController:self.opponentViewController frame:self.opponentViewContainer.frame];
  
  [self.battleController openBattleControllerWebSocket];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    // TODO: if we end battle, we may want to invalidate this timer earlier
    //[self.timer invalidate];
  [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - IBAction

- (IBAction)back:(id)aSender
{
  [self.battleController prepareBattleControllerForDismiss];
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showSettingsModal:(UIButton *)sender
{
  if (self.settingsViewController == nil)
  {
    self.settingsViewController = [[RPGQuickSettingsViewController new] autorelease];
  }
  
  self.settingsView = self.settingsViewController.view;
  self.settingsView.frame = self.view.frame;
  [self.view addSubview:self.settingsView];
}

#pragma mark - Timer

- (void)restartTimer
{
  [self.timer invalidate];
  self.timerCounter = kRPGBattleTurnDuration;
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(updateTimerLabel:)
                                              userInfo:nil
                                               repeats:YES];
  [self updateTimerLabel:nil];
}

- (void)updateTimerLabel:(NSTimer *)aTimer
{
  self.timerLabel.text = [@(self.timerCounter) stringValue];
  if (self.timerCounter > 0)
  {
    self.timerCounter -= 1;
  }
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
    [self addChildViewController:self.battleRewardModal frame:self.view.frame];
    
    [self updateRewardModal];
    
    [self.timer invalidate];
    [self.battleController prepareBattleControllerForDismiss];
  }
  
    // skillbar
  if (battleController.isMyTurn)
  {
    [self.skillBarViewController updateButtonsState];
  }
}

- (void)updateRewardModal
{
  RPGBattleController *battleController = self.battleController;
  
  NSString *playerNickName = battleController.playerNickName;
  NSString *opponentNickName = battleController.opponentNickName;
  
  self.winnerNickNameLabel.text = battleController.battleStatus == 0 ? opponentNickName : playerNickName;
  self.rewardGoldLabel.text = [NSString stringWithFormat:@"%ld", (long)battleController.rewardGold];
  self.rewardCrystalsLabel.text = [NSString stringWithFormat:@"%ld", (long)battleController.rewardCrystals];
  self.rewardExpLabel.text = [NSString stringWithFormat:@"%ld", (long)battleController.rewardExp];
}

- (void)battleInitDidEndSetUp:(NSNotification *)aNotification
{
  [self removeBattleInitModal];
  [self setUpEntityViewControllers];
}

- (void)removeBattleInitModal
{
  [self restartTimer];
  [self.battleInitModal.view removeFromSuperview];
  [self.battleInitModal removeFromParentViewController];
}

- (void)setUpEntityViewControllers
{
  self.playerViewController.entity = self.battleController.battle.player;
  self.opponentViewController.entity = self.battleController.battle.opponent;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary<NSString *,id> *)aChange
                       context:(void *)aContext
{
  if (aContext == &sRPGBattleViewContollerBattleControllerBattleCurrentTurnContext)
  {
    BOOL oldCurrentTurn = [aChange[NSKeyValueChangeOldKey] boolValue];
    BOOL newCurrentTurn = [aChange[NSKeyValueChangeNewKey] boolValue];
    
    if (oldCurrentTurn != newCurrentTurn)
    {
      [self restartTimer];
    }
  }
  else
  {
    [super observeValueForKeyPath:aKeyPath ofObject:anObject change:aChange context:aContext];
  }
}

@end
