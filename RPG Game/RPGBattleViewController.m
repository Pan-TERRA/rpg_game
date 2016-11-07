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
#import "RPGSFXEngine.h"
#import "SRWebSocket.h"
#import "NSUserDefaults+RPGSessionInfo.h"
#import "RPGBattleInitResponse+Serialization.h"
  // Constants
#import "RPGNibNames.h"
  // Custom Views
#import "RPGProgressBar.h"

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
@property (nonatomic, assign, readwrite) IBOutlet UILabel *timer;

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
    }
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [_battleManager release];
  
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

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self.battleManager close];
}

- (void)viewDidDisappear:(BOOL)animated
{
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

#pragma mark  Skill Action

- (IBAction)spell1_action:(UIButton *)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:1];
  
  [self.battleManager sendSkillActionRequestWithID:aSender.tag];
}

- (IBAction)spell2_action:(id)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:2];
}

- (IBAction)spell3_action:(id)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:3];
}

- (IBAction)spell4_action:(id)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:4];
}

- (IBAction)spell5_action:(id)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:5];
}

- (IBAction)spell6_action:(id)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:6];
}

- (IBAction)spell7_action:(id)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:7];
}

#pragma mark - Notifications

- (void)modelDidChange:(NSNotification *)aNotification
{
  RPGBattle *battle = self.battleManager.battle;

    // client
  NSInteger playerHP = battle.player.HP;
  self.player1NickName.text = battle.player.name;
  self.player1hp.text = [@(playerHP) stringValue];
  self.player1hpBar.progress = ((float)playerHP / 100);
  [self.player1hpBar setNeedsDisplay];
    // opponent
  NSInteger opponentHP = battle.opponent.HP;
  self.player2NickName.text = battle.opponent.name;
  self.player2hp.text = [@(opponentHP) stringValue];
  self.player2hpBar.progress = ((float)opponentHP / 100);
  [self.player2hpBar setNeedsDisplay];
  
}

@end
