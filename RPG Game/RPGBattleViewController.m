//
//  RPGBattleViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

//view
#import "RPGBattleViewController.h"
#import "RPGSkillBarViewController.h"
  // API
#import "RPGBattleManager.h"
#import "SRWebSocket.h"
  // Entities
#import "RPGBattle.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGResources.h"
#import "RPGBattleInitResponse.h"
  // Views
#import "RPGProgressBar.h"
#import "RPGBattleLogViewController.h"
  // Misc
#import "RPGBackgroundMusicController.h"
#import "NSUserDefaults+RPGSessionInfo.h"
  // Constants
#import "RPGNibNames.h"

static int kRPGBattleViewContollerBattleManagerBattleCurrentTurnContext;

@interface RPGBattleViewController ()

@property(nonatomic, retain, readwrite) RPGBattleManager *battleManager;

// Player 1
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player1NickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *player1hpBar;
// Player 2
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player2NickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *player2hpBar;
  // Battle log
@property (nonatomic, retain, readwrite) RPGBattleLogViewController *battleLogViewController;
@property (nonatomic, assign, readwrite) IBOutlet UITextView *battleTextView;
// Misc
@property (nonatomic, assign, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain, readwrite) NSTimer *timer;
@property (nonatomic, assign, readwrite) NSInteger timerCounter;

@property (nonatomic, retain, readwrite) IBOutlet UIViewController *battleRewardModal;
#warning - ?
@property (nonatomic, assign, readwrite) IBOutlet UILabel *winnerNickNameLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *playerRewardLabel;

@property (nonatomic, retain, readwrite) IBOutlet UIViewController *battleInitModal;
//skill bar
@property (nonatomic, retain, readwrite) RPGSkillBarViewController *skillBarViewController;
@property (nonatomic, assign, readwrite) IBOutlet UIView *skillBar;
//tooltip
@property (nonatomic, assign, readwrite) UIView *tooltip;

@end

@implementation RPGBattleViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGBattleViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleManager = [[RPGBattleManager alloc] init];
    _skillBarViewController = [[RPGSkillBarViewController alloc] initWithBattleManager:_battleManager];
    //TODO: remove hardcode
    [self addObserver:_skillBarViewController
           forKeyPath:@"battleManager.battle.player"
              options:NSKeyValueObservingOptionNew
              context:nil];
    
    [_battleManager open];
    
    if (_battleManager != nil)
    {
      _battleLogViewController = [[RPGBattleLogViewController alloc]
                                  initWithBattleManager:_battleManager];
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(modelDidChange:)
                                                   name:kRPGBattleManagerModelDidChangeNotification
                                                 object:_battleManager];
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(removeBattlleInitModal:)
                                                   name:kRPGBattleManagerDidEndSetUpNotification
                                                 object:_battleManager];
      [_battleManager addObserver:self
                       forKeyPath:@"battle.currentTurn"
                          options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                          context:&kRPGBattleViewContollerBattleManagerBattleCurrentTurnContext];
    }
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  //TODO: remove hardcode
  [self removeObserver:_skillBarViewController forKeyPath:@"battleManager.battle.player"];
  [_battleManager removeObserver:self
                      forKeyPath:@"battle.currentTurn"
                         context:&kRPGBattleViewContollerBattleManagerBattleCurrentTurnContext];
  [_battleLogViewController release];
  [_battleManager release];
  [_battleRewardModal release];
  [_battleInitModal release];
  [_skillBarViewController release];

  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.battleLogViewController.view = self.battleTextView;
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToBattle];
  
  //battle init modal
  [self addChildViewController:self.battleInitModal];
  self.battleInitModal.view.frame = self.view.frame;
  [self.view addSubview:self.battleInitModal.view];
  [self.battleInitModal didMoveToParentViewController:self];
  
  //skill bar view
  [self addChildViewController:self.skillBarViewController];
  CGSize size = self.skillBar.frame.size;
  self.skillBarViewController.view.frame = CGRectMake(0, 0, size.width, size.height);
  [self.skillBar addSubview:self.skillBarViewController.view];
  [self.skillBarViewController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self restartTimer];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self.battleManager close];
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
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Tooltips
- (void)showTooltipWithView:(UIView *)view
{
  if (self.tooltip != nil)
  {
    [self.tooltip removeFromSuperview];
    self.tooltip = nil;
  }
  //check for correct size
  view.frame = self.view.frame;
  
  self.tooltip = view;
  [self.view addSubview:view];
}

- (IBAction)removeTooltip:(UITapGestureRecognizer *)recognizer
{
  [self.tooltip removeFromSuperview];
  self.tooltip = nil;
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
  // TODO: Add battle condition request if something went wrong with time.
}

#pragma mark - Notifications

- (void)modelDidChange:(NSNotification *)aNotification
{
  RPGBattle *battle = self.battleManager.battle;

    // client
  NSInteger playerHP = battle.player.HP;
  NSString *playerName = battle.player.name;
  self.player1NickName.text = playerName;
  self.player1hpBar.progress = ((float)playerHP / 100.0);
    // opponent
  NSInteger opponentHP = battle.opponent.HP;
  NSString *opponentName = battle.opponent.name;
  self.player2NickName.text = opponentName;
  self.player2hpBar.progress = ((float)opponentHP / 100.0);
  
    // fight end
  if (playerHP == 0 || opponentHP == 0)
  {
    [self addChildViewController:self.battleRewardModal];
    self.battleRewardModal.view.frame = self.view.frame;
    [self.view addSubview:self.battleRewardModal.view];
    [self.battleRewardModal didMoveToParentViewController:self];
    
    self.winnerNickNameLabel.text = playerHP == 0 ? opponentName : playerName;
    self.playerRewardLabel.text = [NSString stringWithFormat:@"%ld", (long)battle.reward.gold];
    
    [self.timer invalidate];
  }
}

- (void)removeBattlleInitModal:(NSNotification *)aNotification
{
  [self.battleInitModal.view removeFromSuperview];
  [self.battleInitModal removeFromParentViewController];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary<NSString *,id> *)aChange
                       context:(void *)aContext
{
  if (aContext == &kRPGBattleViewContollerBattleManagerBattleCurrentTurnContext)
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
