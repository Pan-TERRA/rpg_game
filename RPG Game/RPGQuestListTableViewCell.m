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
#import "RPGQuestReward.h"
#import "RPGQuest.h"
#import "RPGQuestReward.h"
#import "RPGQuestTableViewController.h"
#import "RPGSkillRepresentation.h"

static CGFloat const kBounceValue = 10.0;

@interface RPGQuestListTableViewCell()  <UIGestureRecognizerDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *stateImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *skillRewardImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *deleteButton;

@property (nonatomic, retain, readwrite) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
@property (nonatomic, assign, readwrite) CGFloat startRightConstraintConstant;

@property (nonatomic, assign, readwrite) RPGQuestState questState;
@property (nonatomic, assign, readwrite) NSUInteger questID;

@end

@implementation RPGQuestListTableViewCell

#pragma mark - Dealloc

- (void)dealloc
{
  [_panGestureRecognizer release];
  
  [super dealloc];
}

#pragma mark - UITableViewCell

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  self.panGestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)] autorelease];
  self.panGestureRecognizer.delegate = self;
  [self addGestureRecognizer:self.panGestureRecognizer];
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
  self.questState = aCellContent.state;
  self.questID = aCellContent.questID;
  
  if (aCellContent.reward.skillID != 0)
  {
    RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:aCellContent.reward.skillID];
    self.skillRewardImageView.image = [UIImage imageNamed:skillRepresentation.imageName];
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
      self.stateImageView.image = [UIImage imageNamed:@"timer"];
      [self setStateLabelHidden:NO];
      break;
    }
      
    case kRPGQuestStateDone:
    {
      self.stateImageView.image = [UIImage imageNamed:@"user-review"];
      [self setStateLabelHidden:NO];
      break;
    }
      
    case kRPGQuestStateReviewedFalse:
    {
      self.stateImageView.image = [UIImage imageNamed:@"forbidden"];
      [self setStateLabelHidden:NO];
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

#pragma mark - Actions

- (IBAction)deleteButtonOnClick:(UIButton *)sender
{
  [self.delegate deleteQuestWithID:self.questID];
}

#pragma mark - Cell State

- (void)setStateLabelHidden:(BOOL)aFlag
{
  if (aFlag)
  {
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

#pragma mark - UIPanGestureRecognizer

- (void)panAction:(UIPanGestureRecognizer *)aRecognizer
{
  switch (aRecognizer.state)
  {
    case UIGestureRecognizerStateBegan:
    {
      self.startRightConstraintConstant = self.contentViewRightConstraint.constant;
      break;
    }
      
    case UIGestureRecognizerStateChanged:
    {
      CGPoint currentPoint = [aRecognizer translationInView:self];
      CGFloat shift = self.startRightConstraintConstant - currentPoint.x;
      if (shift > 0 && shift < [self buttonWidth])
      {
        self.contentViewRightConstraint.constant = shift;
        self.contentViewLeftConstraint.constant = -shift;
      }
      break;
    }
    
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled:
    {
      CGFloat constraintValue = 0;
      if (self.contentViewRightConstraint.constant > [self buttonWidth] / 2.0)
      {
        constraintValue = [self buttonWidth];
      }
      [self setConstraints:constraintValue];
      break;
    }
      
    default:
    {
      break;
    }
  }
}

- (void)setConstraints:(CGFloat)aConstraintValue
{
  self.contentViewRightConstraint.constant = aConstraintValue;
  self.contentViewLeftConstraint.constant = -aConstraintValue;
}

- (CGFloat)buttonWidth
{
  return self.deleteButton.frame.size.width + kBounceValue;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  BOOL result = NO;
  if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
  {

    UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer*)gestureRecognizer;
    UIView *cell = [panGestureRecognizer view];
    CGPoint translation = [panGestureRecognizer translationInView:[cell superview]];
    
    if ([self canDeleteQuest] && fabs(translation.x) > fabs(translation.y))
    {
      result = YES;
    }
  }
  return result;
}

- (BOOL)canDeleteQuest
{
  BOOL result = NO;
  RPGQuestState state = self.questState;
  if (state == kRPGQuestStateCanTake ||
      state == kRPGQuestStateInProgress ||
      state == kRPGQuestStateReviewedFalse)
  {
    result = YES;
  }
  return result;
}

@end
