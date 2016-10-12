//
//  RPGQuestListTableViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestListTableViewCell.h"
#import "RPGQuestListViewController.h"

static NSString *const kRPGQuestListTableViewCellTitle = @"title";
static NSString *const kRPGQuestListTableViewCellDescription = @"description";
static NSString *const kRPGQuestListTableViewCellReward = @"reward";
static NSString *const kRPGQuestListTableViewCellState = @"state";

@interface RPGQuestListTableViewCell()

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *rewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImage;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *rewardTypeImage;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateLabel;

@end

@implementation RPGQuestListTableViewCell

- (void)awakeFromNib
{
  [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

- (void)dealloc
{
  [super dealloc];
}

- (void)setCellContent:(NSDictionary *)cellContent
{
  self.titleLabel.text = [cellContent objectForKey:kRPGQuestListTableViewCellTitle];
  self.descriptionLabel.text = [cellContent objectForKey:kRPGQuestListTableViewCellDescription];
  self.rewardLabel.text = [cellContent objectForKey:kRPGQuestListTableViewCellReward];
  RPGQuestState state = [[cellContent objectForKey:kRPGQuestListTableViewCellState] integerValue];
  switch (state) {
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