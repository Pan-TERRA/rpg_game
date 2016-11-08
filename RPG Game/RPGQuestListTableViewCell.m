//
//  RPGQuestListTableViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListTableViewCell.h"
  // Views
#import "RPGQuestListViewController.h"
  // Entities
#import "RPGQuestReward+Serialization.h"
#import "RPGQuest+Serialization.h"
#import "RPGQuestReward+Serialization.h"

@interface RPGQuestListTableViewCell()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *stateImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *skillRewardImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;

@end

@implementation RPGQuestListTableViewCell

#pragma mark - UITableViewCell

- (void)awakeFromNib
{
  [super awakeFromNib];
}

- (void)setSelected:(BOOL)aSelected animated:(BOOL)anAnimated
{
  [super setSelected:aSelected animated:anAnimated];
}

#pragma mark - Cell Content

- (void)setCellContent:(RPGQuest *)aCellContent
{
  self.titleLabel.text = aCellContent.name;
  self.descriptionLabel.text = aCellContent.questDescription;
  self.crystalsRewardLabel.text = [@(aCellContent.reward.crystals) stringValue];
  self.goldRewardLabel.text = [@(aCellContent.reward.gold) stringValue];
  
  if (aCellContent.reward.skillID != 0)
  {
    
  }
  else
  {
    [self.skillRewardImageView removeConstraint:[NSLayoutConstraint constraintWithItem:self.skillRewardImageView
                                                                             attribute:NSLayoutAttributeTrailing
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.skillRewardImageView.superview
                                                                             attribute:NSLayoutAttributeTrailing
                                                                            multiplier:1.0
                                                                              constant:10]];
    [self.skillRewardImageView removeConstraint:[NSLayoutConstraint constraintWithItem:self.skillRewardImageView
                                                                             attribute:NSLayoutAttributeLeading
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.goldRewardLabel
                                                                             attribute:NSLayoutAttributeTrailing
                                                                            multiplier:1.0
                                                                              constant:10]];
    [self.skillRewardImageView removeFromSuperview];
    [self.goldRewardLabel.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.goldRewardLabel.superview
                                                                               attribute:NSLayoutAttributeTrailing
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.goldRewardLabel
                                                                               attribute:NSLayoutAttributeTrailing
                                                                              multiplier:1.0
                                                                                constant:10]];
  }

  switch (aCellContent.state)
  {
    case kRPGQuestStateCanTake:
    {
      [self setStateLabelHidden:YES];
      break;
    }
    case kRPGQuestStateInProgress:
    {
      [self setStateLabelHidden:NO];
      //self.stateLabel.text = kRPGQuestStringStateInProgress;
      break;
    }
    case kRPGQuestStateDone:
    {
      [self setStateLabelHidden:NO];
      //self.stateLabel.text = kRPGQuestStringStateNotReviewed;
      break;
    }
    case kRPGQuestStateReviewedFalse:
    {
      [self setStateLabelHidden:NO];
      //self.stateLabel.text = kRPGQuestStringStateReviewedFalse;
      break;
    }
    case kRPGQuestStateReviewedTrue:
    {
      [self setStateLabelHidden:YES];
      break;
    }
    default:
    {
      break;
    }
  }
}

#pragma mark - Cell State

- (void)setStateLabelHidden:(BOOL)aFlag
{
  if (aFlag) {
    [self.stateImageView removeConstraint:[NSLayoutConstraint constraintWithItem:self.stateImageView
                                                                       attribute:NSLayoutAttributeTrailing
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.stateImageView.superview
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:10]];
    [self.stateImageView removeConstraint:[NSLayoutConstraint constraintWithItem:self.stateImageView
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.stateTitleLabel
                                                                       attribute:NSLayoutAttributeTrailing
                                                                      multiplier:1.0
                                                                        constant:10]];
    [self.stateImageView removeFromSuperview];
    [self.stateTitleLabel removeConstraint:[NSLayoutConstraint constraintWithItem:self.stateTitleLabel
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.proofTypeImageView
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1.0
                                                                         constant:10]];
    
    [self.stateTitleLabel removeFromSuperview];
    [self.proofTypeImageView.superview addConstraint:[NSLayoutConstraint constraintWithItem:self.proofTypeImageView.superview
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.proofTypeImageView
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                 multiplier:1.0
                                                                                   constant:10]];
  }
}

@end
