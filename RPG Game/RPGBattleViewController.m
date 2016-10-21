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

#import "RPGBattleManager.h"
#import "RPGSFXEngine.h"
#import "SRWebSocket.h"

  // Constants
#import "RPGNibNames.h"


@interface RPGBattleViewController () <SRWebSocketDelegate>

@property(nonatomic, retain, readwrite) RPGBattleManager *battleManager;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *player1NickName;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player2NickName;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player1hp;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *player2hp;
@property (nonatomic, assign, readwrite) IBOutlet UIProgressView *player1hpBar;
@property (nonatomic, assign, readwrite) IBOutlet UIProgressView *player2hpBar;
@property (nonatomic, assign, readwrite) IBOutlet UITextView *battleTextView;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell1Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell2Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell3Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell4Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell5Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell6Button;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *spell7Button;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *timer;

@end

@implementation RPGBattleViewController

#pragma mark - Init

- (instancetype)init
{
  return [super initWithNibName:kRPGBattleViewController
                         bundle:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToBattle];
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)back:(id)aSender
{
  [[RPGBackgroundMusicController sharedBackgroundMusicController] switchToPeace];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)spell1_action:(id)aSender
{
  [[RPGSFXEngine sharedSFXEngine] playSFXWithSpellID:1];
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

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
  
}

- (void)webSocket:(SRWebSocket *)webSocket
  idCloseWithCode:(NSInteger)code
           reason:(nullable NSString *)reason
         wasClean:(BOOL)wasClean
{
  
}

@end
