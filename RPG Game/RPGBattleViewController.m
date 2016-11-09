//
//  RPGBattleViewController.m
//  RPG Game
//
//  Created by Владислав Крут on 10/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

  // View
#import "RPGBattleViewController.h"
#import "RPGBackgroundMusicController.h"
  // Misc
#import "RPGBattleManager.h"
#import "RPGBattle.h"
#import "SRWebSocket.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGBattleInitResponse+Serialization.h"
#import "RPGResources.h"
  // Constants
#import "RPGNibNames.h"
  // Custom Views
#import "RPGProgressBar.h"

static int kRPGBattleViewContollerBattleManagerBattleCurrentTurnContext;

@interface RPGBattleViewController ()

@property(nonatomic, retain, readwrite) RPGBattleManager *battleManager;

  // Player 1
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player1NickName;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player1hp;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *player1hpBar;
  // Player 2
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player2NickName;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player2hp;
@property (nonatomic, assign, readwrite) IBOutlet RPGProgressBar *player2hpBar;
  // Skill bar
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell1Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell2Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell3Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell4Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell5Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell6Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell7Button;
  // Misc
@property (nonatomic, assign, readwrite) IBOutlet UITextView *battleTextView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain, readwrite) NSTimer *timer;
@property (nonatomic, assign, readwrite) NSInteger timerCounter;

@property (nonatomic, retain, readwrite) IBOutlet UIViewController *battleRewardModal;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *winnerNickNameLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *playerRewardLabel;

@end

@implementation RPGBattleViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super initWithNibName:kRPGBattleViewControllerNIBName bundle:nil];
  
  if (self != nil)
  {
    _battleManager = [[RPGBattleManager alloc] init];
    [_battleManager open];
    
    if (_battleManager != nil)
    {
      [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(modelDidChange:)
                                                   name:kRPGBattleManagerModelDidChangeNotification
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
  [_battleManager removeObserver:self
                      forKeyPath:@"battle.currentTurn"
                         context:&kRPGBattleViewContollerBattleManagerBattleCurrentTurnContext];
  [_battleManager release];
  [_battleRewardModal release];

  [super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToBattle];
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

#pragma mark - Skill Action

- (IBAction)skillAction:(UIButton *)aSender
{
  NSArray *skills = self.battleManager.battle.player.skills;

  NSInteger tag = aSender.tag;
    // array range check
  if (tag <= skills.count)
  {
    [self.battleManager sendSkillActionRequestWithID:[skills[tag] integerValue]];
  }
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
  self.player1hp.text = [@(playerHP) stringValue];
  self.player1hpBar.progress = ((float)playerHP / 100.0);
    // opponent
  NSInteger opponentHP = battle.opponent.HP;
  NSString *opponentName = battle.opponent.name;
  self.player2NickName.text = opponentName;
  self.player2hp.text = [@(opponentHP) stringValue];
  self.player2hpBar.progress = ((float)opponentHP / 100.0);
  
  if (playerHP == 0 || opponentHP == 0)
  {
    [self addChildViewController:self.battleRewardModal];
    self.battleRewardModal.view.frame = self.view.frame;
    [self.view addSubview:self.battleRewardModal.view];
    [self.battleRewardModal didMoveToParentViewController:self];
    self.winnerNickNameLabel.text = playerHP == 0 ? opponentName : playerName;
    self.playerRewardLabel.text = [NSString stringWithFormat:@"%ld", battle.reward.gold];
    [self.timer invalidate];
  }
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
