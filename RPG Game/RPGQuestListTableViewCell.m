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

#pragma mark - UITableViewCell methods

- (void)awakeFromNib
{
  [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

#pragma mark - set cell state and content

- (void)setCellContent:(NSDictionary *)cellContent
{
  self.titleLabel.text = [cellContent objectForKey:kRPGQuestListViewControllerQuestTitle];
  self.descriptionLabel.text = [cellContent objectForKey:kRPGQuestListViewControllerQuestDescription];
  self.rewardLabel.text = [cellContent objectForKey:kRPGQuestListViewControllerQuestReward];
  RPGQuestState state = [[cellContent objectForKey:kRPGQuestListViewControllerQuestState] integerValue];
  switch (state)
  {
    case kRPGQuestStateCanTake:
      [self setStateLabelHidden:YES];
      break;
    case kRPGQuestStateInProgress:
      [self setStateLabelHidden:NO];
      self.stateLabel.text = @"In progress";
      break;
    case kRPGQuestStateDone:
      [self setStateLabelHidden:NO];
      self.stateLabel.text = @"Not reviewed";
      break;
    case kRPGQuestStateReviewedFalse:
      [self setStateLabelHidden:NO];
      self.stateLabel.text = @"Reviewed false";
      break;
    case kRPGQuestStateReviewedTrue:
      [self setStateLabelHidden:YES];
      break;
    default:
      break;
  }
}

- (void)setStateLabelHidden:(BOOL)flag
{
  self.stateTitleLabel.hidden = flag;
  self.stateLabel.hidden = flag;
}

@end