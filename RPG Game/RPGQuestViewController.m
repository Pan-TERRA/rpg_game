//
//  RPGQuestViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestViewController.h"

@interface RPGQuestViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *denyButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *addProofButton;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *proofLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView;

@end

@implementation RPGQuestViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  switch (self.state) {
    case kRPGQuestListViewTakeQuest:
      [self setForTakeQuest];
      break;
    case kRPGQuestListViewInProgressQuest:
      [self setForInProgressQuest];
      break;
    case kRPGQuestListViewDoneQuest:
      [self setForDoneQuest];
      break;
    case kRPGQuestListViewCheckQuest:
      [self setForCheckQuest];
      break;
    default:
      break;
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)setForTakeQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = NO;
  self.addProofButton.hidden = YES;
  self.proofLabel.hidden = YES;
  self.proofImageView.hidden = YES;
}

- (void)setForInProgressQuest
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = NO;
  self.proofLabel.hidden = YES;
  self.proofImageView.hidden = YES;
}

- (void)setForDoneQuest
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = YES;
  self.proofLabel.hidden = NO;
  self.proofImageView.hidden = NO;
}

- (void)setForCheckQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = NO;
  self.addProofButton.hidden = YES;
  self.proofLabel.hidden = NO;
  self.proofImageView.hidden = NO;
}

- (IBAction)acceptButtonOnClick:(UIButton *)sender
{
  switch (self.state) {
    case kRPGQuestListViewTakeQuest:
      //insert code here
      break;
    case kRPGQuestListViewCheckQuest:
      //insert code here
      break;
    default:
      break;
  }
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)denyButtonOnClick:(UIButton *)sender
{
  switch (self.state) {
    case kRPGQuestListViewTakeQuest:
      //insert code here
      break;
    case kRPGQuestListViewCheckQuest:
      //insert code here
      break;
    default:
      break;
  }
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addProofButtonOnClick:(UIButton *)sender
{
  
}

- (IBAction)backButtonOnClick:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
  [_proofLabel release];
  [super dealloc];
}
@end