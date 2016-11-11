//
//  RPGBattleViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

// View
#import "RPGBattleViewController.h"
#import "RPGSkillBarViewController.h"
#import "RPGBackgroundMusicController.h"
// Misc
#import "RPGBattleManager.h"
#import "RPGBattle.h"
#import "SRWebSocket.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGBattleInitResponse.h"
// Constants
#import "RPGNibNames.h"
// Custom Views
#import "RPGProgressBar.h"

static int kRPGBattleViewContollerBattleManagerBattleCurrentTurnContext;

@interface RPGBattleViewController ()

@property(nonatomic, retain, readwrite) RPGBattleManager *battleManager;

// Player 1
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player1NickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *player1hpBar;
// Player 2
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player2NickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *player2hpBar;
// Misc
@property (nonatomic, assign, readwrite) IBOutlet UITextView *battleTextView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain, readwrite) NSTimer *timer;
@property (nonatomic, assign, readwrite) NSInteger timerCounter;

@property (retain, nonatomic) IBOutlet UIViewController *battleInitModal;
//skill bar
@property (retain, nonatomic) RPGSkillBarViewController *skillBarViewController;
@property (assign, nonatomic) IBOutlet UIView *skillBar;
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
  [_battleManager release];
  [_battleInitModal release];
  [_skillBarViewController release];
  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
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
  [self.timer invalidate];
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
  CGRect frame = self.view.frame;
  view.frame = frame;
  
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
  self.player1NickName.text = battle.player.name;
  self.player1hpBar.progress = ((float)playerHP / 100);
  // opponent
  NSInteger opponentHP = battle.opponent.HP;
  self.player2NickName.text = battle.opponent.name;
  self.player2hpBar.progress = ((float)opponentHP / 100);
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
