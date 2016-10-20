//
//  RPGQuestListTableViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListTableViewCell.h"
#import "RPGQuestListViewController.h"

@interface RPGQuestListTableViewCell()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *rewardTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateLabel;

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

#pragma mark - Set cell state and content

- (void)setCellContent:(NSDictionary *)aCellContent
{
  self.titleLabel.text = [aCellContent objectForKey:kRPGQuestTitle];
  self.descriptionLabel.text = [aCellContent objectForKey:kRPGQuestDescription];
  self.rewardLabel.text = [aCellContent objectForKey:kRPGQuestReward];
  RPGQuestState state = [[aCellContent objectForKey:kRPGQuestState] integerValue];
  switch (state)
  {
    case kRPGQuestStateCanTake:
    {
      [self setStateLabelHidden:YES];
      break;
    }
    case kRPGQuestStateInProgress:
    {
      [self setStateLabelHidden:NO];
      self.stateLabel.text = kRPGQuestStringStateInProgress;
      break;
    }
    case kRPGQuestStateDone:
    {
      [self setStateLabelHidden:NO];
      self.stateLabel.text = kRPGQuestStringStateNotReviewed;
      break;
    }
    case kRPGQuestStateReviewedFalse:
    {
      [self setStateLabelHidden:NO];
      self.stateLabel.text = kRPGQuestStringStateReviewedFalse;
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

- (void)setStateLabelHidden:(BOOL)aFlag
{
  self.stateTitleLabel.hidden = aFlag;
  self.stateLabel.hidden = aFlag;
}

@end
