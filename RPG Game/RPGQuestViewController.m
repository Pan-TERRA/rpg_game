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
  switch (self.state)
  {
    case kRPGQuestListViewTakeQuest:
      [self setForTakeQuest];
      break;
    case kRPGQuestListViewInProgressQuest:
      [self setForInProgressQuest];
      break;
    case kRPGQuestListViewDoneQuest:
      [self setForDoneQuest];
      break;
    case kRPGQuestListViewReviewQuest:
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
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = NO;
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
  if (self.state == kRPGQuestListViewTakeQuest)
  {
    //send to server that quest should be in progress
  }
  else if (self.state == kRPGQuestListViewReviewQuest)
  {
    //send to server that quest was done
  }
}

- (IBAction)denyButtonOnClick:(UIButton *)sender
{
  //send to server that quest wasn't done
}

- (IBAction)addProofButtonOnClick:(UIButton *)sender
{
  //open camera to make photo
}

- (IBAction)backButtonOnClick:(UIButton *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
  [super dealloc];
}

@end