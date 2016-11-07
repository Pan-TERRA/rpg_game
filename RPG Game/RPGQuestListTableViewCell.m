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

@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *stateImageView;

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
    self.skillRewardImageView.hidden = YES;
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
  self.stateTitleLabel.hidden = aFlag;
  self.stateImageView.hidden = aFlag;
}

- (void)dealloc {
  [_stateImageView release];
  [super dealloc];
}
@end
