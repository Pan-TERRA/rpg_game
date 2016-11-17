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
#import "SRWebSocket.h"
  // Controllers
#import "RPGSkillBarViewController.h"
  // Entities
#import "RPGBattle.h"
#import "RPGResources.h"
#import "RPGBattleInitResponse.h"
  // Views
#import "RPGProgressBar.h"
#import "RPGBattleLogViewController.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGBackgroundMusicController.h"
  // Constants
#import "RPGNibNames.h"

static int sRPGBattleViewContollerBattleControllerBattleCurrentTurnContext;

@interface RPGBattleViewController ()

@property(nonatomic, retain, readwrite) RPGBattleController *battleController;

  // Player 1
@property (nonatomic, assign, readwrite) IBOutlet UILabel *playerNickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *playerHPBar;
  // Player 2
@property (nonatomic, assign, readwrite) IBOutlet UILabel *opponentNickName;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *opponentHPBar;
  // Battle log
@property (nonatomic, retain, readwrite) RPGBattleLogViewController *battleLogViewController;
@property (nonatomic, assign, readwrite) IBOutlet UITextView *battleTextView;
  // Misc
@property (nonatomic, assign, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain, readwrite) NSTimer *timer;
@property (nonatomic, assign, readwrite) NSInteger timerCounter;
  // Reward
@property (nonatomic, retain, readwrite) IBOutlet UIViewController *battleRewardModal;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *winnerNickNameLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *playerRewardLabel;

@property (nonatomic, retain, readwrite) IBOutlet UIViewController *battleInitModal;

  // Skill bar
@property (nonatomic, retain, readwrite) RPGSkillBarViewController *skillBarViewController;
@property (nonatomic, assign, readwrite) IBOutlet UIView *skillBar;
  // Tooltip
@property (nonatomic, assign, readwrite) UIView *tooltip;

@end

@implementation RPGBattleViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGBattleViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleController = [[RPGBattleController alloc] init];
    _timerCounter = kRPGBattleTurnDuration;
    if (_battleController != nil)
    {
      _battleLogViewController = [[RPGBattleLogViewController alloc] initWithBattleController:_battleController];
      _skillBarViewController = [[RPGSkillBarViewController alloc] initWithBattleController:_battleController];
      
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

- (IBAction)cancelBattleInit:(UIButton *)sender
{
  [self.battleController prepareBattleControllerForDismiss];
  [self removeBattleInitModal];
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Tooltip

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
}

#pragma mark - Notifications

- (void)modelDidChange:(NSNotification *)aNotification
{
  RPGBattleController *battleController = self.battleController;
  
    // client
  NSInteger playerHP = battleController.playerHP;
  NSString *playerNickName = battleController.playerNickName;
  self.playerNickName.text = playerNickName;
  self.playerHPBar.progress = ((float)playerHP / 100.0);
    // opponent
  NSInteger opponentHP = battleController.opponentHP;
  NSString *opponentNickName = battleController.opponentNickName;
  self.opponentNickName.text = opponentNickName;
  self.opponentHPBar.progress = ((float)opponentHP / 100.0);
  
    // fight end
  if (playerHP == 0 || opponentHP == 0)
  {
    [self addChildViewController:self.battleRewardModal];
    self.battleRewardModal.view.frame = self.view.frame;
    [self.view addSubview:self.battleRewardModal.view];
    [self.battleRewardModal didMoveToParentViewController:self];
    
    self.winnerNickNameLabel.text = playerHP == 0 ? opponentNickName : playerNickName;
    self.playerRewardLabel.text = [NSString stringWithFormat:@"%ld", (long)battleController.rewardGold];
    
    [self.timer invalidate];
  }
  
    // skillbar
  if (self.battleController.isMyTurn)
  {
    [self.skillBarViewController updateButtonsState];
  }
}

- (void)battleInitDidEndSetUp:(NSNotification *)aNotification
{
  [self removeBattleInitModal];
}

- (void)removeBattleInitModal
{
  [self restartTimer];
  [self.battleInitModal.view removeFromSuperview];
  [self.battleInitModal removeFromParentViewController];
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
