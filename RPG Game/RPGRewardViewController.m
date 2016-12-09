  //
  //  RPGRewardViewController.m
  //  RPG Game
  //
  //  Created by Иван Дзюбенко on 12/1/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGRewardViewController.h"
  // Controllers
#import "RPGBattleController+RPGBattlePresentationController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGRewardViewController ()

@property (nonatomic, assign, readwrite) RPGBattleController  *battleController;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *winnerNickNameLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardGoldLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardCrystalsLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardExpLabel;

@end

@implementation RPGRewardViewController

#pragma mark - Init

- (instancetype)initWithBattleController:(RPGBattleController *)aBattleController
{
  self = [self initWithNibName:kRPGRewardViewControllerNIBName
                        bundle:nil];
  
  if (self != nil)
  {
    _battleController = aBattleController;
  }
  
  return self;
}

- (instancetype)init
{
  return [super initWithNibName:kRPGRewardViewControllerNIBName
                         bundle:nil];
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

- (void)updateView
{
  RPGBattleController *battleController = self.battleController;
  
  NSString *playerNickName = battleController.playerNickName;
  NSString *opponentNickName = battleController.opponentNickName;
  
  self.winnerNickNameLabel.text = battleController.battleStatus == 0 ? opponentNickName : playerNickName;
  self.rewardGoldLabel.text = [NSString stringWithFormat:@"%ld", (long)battleController.rewardGold];
  self.rewardCrystalsLabel.text = [NSString stringWithFormat:@"%ld", (long)battleController.rewardCrystals];
  self.rewardExpLabel.text = [NSString stringWithFormat:@"%ld", (long)battleController.rewardExp];
}

- (IBAction)buttonOKAction:(UIButton *)aSender
{
  [self.delegate dismissRewardModal:self];
}

@end
