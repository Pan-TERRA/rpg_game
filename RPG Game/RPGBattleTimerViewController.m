//
//  RPGBattleTimerViewController.m
//  RPG Game
//
//  Created by Иван Дзюбенко on 12/2/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBattleTimerViewController.h"
  // Controllers
#import "RPGBattleController.h"

static int sRPGBattleTimerViewControllerBattleControllerBattleCurrentTurnContext;

@interface RPGBattleTimerViewController ()

@property (nonatomic, assign, readwrite) RPGBattleController *battleController;
@property (nonatomic, copy ,readwrite) NSString *timerObservationKeyPath;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *timerLabel;
@property (nonatomic, retain, readwrite) NSTimer *timer;
@property (nonatomic, assign, readwrite) NSInteger timerCounter;
@property (nonatomic, assign, readwrite) NSInteger turnDuration;

@end

@implementation RPGBattleTimerViewController

#pragma mark - Init

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
                            turnDuration:(NSInteger)aTurnDuration
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self != nil)
  {
    _timerObservationKeyPath = nil;
    _battleController = aBattleController;
    _turnDuration = aTurnDuration;
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_battleController removeObserver:self
                         forKeyPath:_timerObservationKeyPath
                            context:&sRPGBattleTimerViewControllerBattleControllerBattleCurrentTurnContext];
  
  [_timerObservationKeyPath release];
  [_timer release];
  
  [super dealloc];
}

- (void)registerTimerObservationKeyPath:(NSString *)aKeyPath
{
  if (aKeyPath != nil)
  {
    self.timerObservationKeyPath = aKeyPath;
    
    [_battleController addObserver:self
                        forKeyPath:self.timerObservationKeyPath
                           options:(NSKeyValueObservingOptionNew & NSKeyValueObservingOptionOld)
                           context:&sRPGBattleTimerViewControllerBattleControllerBattleCurrentTurnContext];
  }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Timer Methods

- (void)restartTimer
{
  [self.timer invalidate];
  self.timerCounter = self.turnDuration;
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

- (void)invalidateTimer
{
  [self.timer invalidate];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary<NSString *,id> *)aChange
                       context:(void *)aContext
{
  if (aContext == &sRPGBattleTimerViewControllerBattleControllerBattleCurrentTurnContext)
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
