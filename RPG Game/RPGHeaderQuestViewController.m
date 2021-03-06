//
//  RPGHeaderQuestViewController.m
//  RPG Game
//
//  Created by Максим Шульга on 12/15/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGHeaderQuestViewController.h"
  // Entities
#import "RPGQuest.h"
#import "RPGQuestReward.h"
#import "RPGSkillRepresentation.h"
  // Views
#import "RPGQuestViewController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGHeaderQuestViewController ()

@property (nonatomic, assign, readwrite) RPGQuestViewController *questViewController;

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *stateImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *skillRewardImageView;

@end

@implementation RPGHeaderQuestViewController

- (instancetype)initWithQuestViewController:(RPGQuestViewController *)aViewController
{
  self = [super initWithNibName:kRPGHeaderQuestViewControllerNIBName
                         bundle:nil];
  
  if (self != nil)
  {
    _questViewController = aViewController;
  }
  
  return self;
}

#pragma mark - View Content

- (void)setViewContent:(RPGQuestReward *)aQuestReward
{
  self.crystalsRewardLabel.text = [@(aQuestReward.crystals) stringValue];
  self.goldRewardLabel.text = [@(aQuestReward.gold) stringValue];
  
  if (aQuestReward.skillID != 0)
  {
    RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:aQuestReward.skillID];
    self.skillRewardImageView.image = [UIImage imageNamed:skillRepresentation.imageName];
  }
  else
  {
    UIImageView *skillRewardView = self.skillRewardImageView;
    UILabel *goldRewardLabel = self.goldRewardLabel;
    UIView *superview = goldRewardLabel.superview;
    [skillRewardView removeFromSuperview];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:superview
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:goldRewardLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:10]];
  }
}

#pragma mark - View State

- (void)updateView
{
  switch (self.questViewController.state)
  {
    case kRPGQuestStateCanTake:
    case kRPGQuestStateForReview:
    case kRPGQuestStateReviewedTrue:
    {
      [self setStateItemsHidden:YES];
      break;
    }
      
    case kRPGQuestStateInProgress:
    {
      self.stateImageView.image = [UIImage imageNamed:@"timer"];
      [self setStateItemsHidden:NO];
      break;
    }
      
    case kRPGQuestStateDone:
    {
      self.stateImageView.image = [UIImage imageNamed:@"user-review"];
      [self setStateItemsHidden:NO];
      break;
    }
    case kRPGQuestStateReviewedFalse:
    {
      self.stateImageView.image = [UIImage imageNamed:@"forbidden"];
      [self setStateItemsHidden:NO];
      break;
    }
  }
}

- (void)setStateItemsHidden:(BOOL)aFlag
{
  if (aFlag)
  {
    UIImageView *proofTypeImageView = self.proofTypeImageView;
    UIView *superview = proofTypeImageView.superview;
    
    [self.stateImageView removeFromSuperview];
    [self.stateTitleLabel removeFromSuperview];
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:superview
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:proofTypeImageView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:10]];
  }
}

@end
