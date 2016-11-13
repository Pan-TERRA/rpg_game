//
//  RPGQuestViewHeaderContainer.m
//  RPG Game
//
//  Created by Максим Шульга on 11/10/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestViewHeaderContainer.h"
  // Entities
#import "RPGQuest.h"
#import "RPGQuestReward.h"
  // View
#import "RPGQuestViewController.h"

@interface RPGQuestViewHeaderContainer()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *stateImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *skillRewardImageView;

@end

@implementation RPGQuestViewHeaderContainer

#pragma mark - View Content

- (void)setViewContent:(RPGQuestReward *)aQuestReward
{
  self.crystalsRewardLabel.text = [@(aQuestReward.crystals) stringValue];
  self.goldRewardLabel.text = [@(aQuestReward.gold) stringValue];
  
  if (aQuestReward.skillID != 0)
  {
    
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
    case kRPGQuestStateDone:
    case kRPGQuestStateReviewedFalse:
    {
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
