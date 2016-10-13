//
//  RPGQuestViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestViewController.h"
#import "RPGQuestListViewController.h"

@interface RPGQuestViewController ()

@property (nonatomic, assign, readwrite) IBOutlet UIButton *acceptButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *denyButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *addProofButton;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *proofLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *rewardTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateLabel;
@property (nonatomic, assign, readwrite) RPGQuestState state;

@end

@implementation RPGQuestViewController

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - set view state and content

- (void)setViewContent:(NSDictionary *)viewContent
{
  self.titleLabel.text = [viewContent objectForKey:kRPGQuestListViewControllerQuestTitle];
  self.descriptionLabel.text = [viewContent objectForKey:kRPGQuestListViewControllerQuestDescription];
  self.rewardLabel.text = [viewContent objectForKey:kRPGQuestListViewControllerQuestReward];
  RPGQuestState state = [[viewContent objectForKey:kRPGQuestListViewControllerQuestState] integerValue];
  switch (state)
  {
    case kRPGQuestStateCanTake:
      [self setStateTakeQuest];
      break;
    case kRPGQuestStateInProgress:
      [self setStateInProgressQuest];
      self.stateLabel.text = @"In progress";
      break;
    case kRPGQuestStateDone:
      [self setStateReviewedQuest:NO];
      self.stateLabel.text = @"Not reviewed";
      break;
    case kRPGQuestStateReviewedFalse:
      [self setStateReviewedQuest:NO];
      self.stateLabel.text = @"Reviewed false";
      break;
    case kRPGQuestStateForReview:
      [self setStateForReviewQuest];
      break;
    case kRPGQuestStateReviewedTrue:
      [self setStateReviewedQuest:YES];
      break;
    default:
      break;
  }
}

- (void)setStateTakeQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = NO;
  [self setProofItemsHidden:YES];
  [self setStateItemsHidden:YES];
}

- (void)setStateInProgressQuest
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = NO;
  [self setProofItemsHidden:YES];
  [self setStateItemsHidden:NO];
}

- (void)setStateReviewedQuest:(BOOL)flag
{
  self.acceptButton.hidden = YES;
  self.denyButton.hidden = YES;
  self.addProofButton.hidden = YES;
  [self setProofItemsHidden:NO];
  [self setStateItemsHidden:flag];
}

- (void)setStateForReviewQuest
{
  self.acceptButton.hidden = NO;
  self.denyButton.hidden = NO;
  self.addProofButton.hidden = YES;
  [self setProofItemsHidden:NO];
  [self setStateItemsHidden:YES];
}

- (void)setProofItemsHidden:(BOOL)flag
{
  self.proofLabel.hidden = flag;
  self.proofImageView.hidden = flag;
}

- (void)setStateItemsHidden:(BOOL)flag
{
  self.stateTitleLabel.hidden = flag;
  self.stateLabel.hidden = flag;
}

#pragma mark - button actions handling

- (IBAction)acceptButtonOnClick:(UIButton *)sender
{
  if (self.state == kRPGQuestStateCanTake)
  {
    //send to server that quest should be in progress
  }
  else if (self.state == kRPGQuestStateForReview)
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

@end