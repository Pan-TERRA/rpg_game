//
//  RPGQuestListTableViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 10/11/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGQuestTableViewCell.h"
  // Views
#import "RPGQuestListViewController.h"
  // Controllers
#import "RPGQuestTableViewController.h"
  // Entities
#import "RPGQuestReward.h"
#import "RPGQuest.h"
#import "RPGDuelQuest.h"
#import "RPGQuestReward.h"
#import "RPGSkillRepresentation.h"
  // Constants
#import "RPGQuestAction.h"
  // Misc
#import "NSUserDefaults+RPGSessionInfo.h"

static CGFloat const kBounceValue = 10.0;

@interface RPGQuestTableViewCell ()  <UIGestureRecognizerDelegate>

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *proofTypeImageView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *stateTitleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *stateImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *crystalsRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *goldRewardLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *skillRewardImageView;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *deleteButton;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *getRewardButton;

@property (nonatomic, assign, readwrite) IBOutlet UILabel *daysLeftLabel;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *countDaysLeftLabel;

@property (nonatomic, retain, readwrite) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *contentViewRightConstraint;
@property (nonatomic, assign, readwrite) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;
@property (nonatomic, assign, readwrite) CGFloat startRightConstraintConstant;

@property (nonatomic, assign, readwrite) RPGQuestState questState;
@property (nonatomic, assign, readwrite) NSUInteger questID;

@end

@implementation RPGQuestTableViewCell

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
  
  self.panGestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(panAction:)] autorelease];
  self.panGestureRecognizer.delegate = self;
  [self addGestureRecognizer:self.panGestureRecognizer];
}

#pragma mark - Cell Content

- (void)setCellContent:(RPGQuest *)aCellContent
{
  RPGQuestState state = aCellContent.state;
  RPGQuestType type = aCellContent.questType;
  RPGDuelQuest *duelQuest = ((RPGDuelQuest *)aCellContent);
  NSString *questTitle = aCellContent.name;
  
  self.descriptionLabel.text = aCellContent.questDescription;
  self.crystalsRewardLabel.text = [@(aCellContent.reward.crystals) stringValue];
  self.goldRewardLabel.text = [@(aCellContent.reward.gold) stringValue];
  self.questState = state;
  self.questID = aCellContent.questID;
  
  if (type == kRPGQuestTypeDuel
      && state != kRPGQuestStateForReview)
  {
    questTitle = [NSString stringWithFormat:@"%@ with %@", questTitle, duelQuest.friendUsername];
    
    if (state == kRPGQuestStateReviewedTrue)
    {
      NSString *winner = duelQuest.isWinner ? [NSUserDefaults standardUserDefaults].characterNickName : duelQuest.friendUsername;
      questTitle = [NSString stringWithFormat:@"%@. Winner is %@", questTitle, winner];
    }
  }
  
  self.titleLabel.text = questTitle;
  
  if (type == kRPGQuestTypeDuel
      && state == kRPGQuestStateInProgress)
  {
    self.countDaysLeftLabel.text = [NSString stringWithFormat:@"%ld", duelQuest.daysLeft];
  }
  else
  {
    [self.daysLeftLabel removeFromSuperview];
    [self.countDaysLeftLabel removeFromSuperview];
  }
  
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

  switch (state)
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
  
  BOOL hiddenFlag = (state == kRPGQuestStateReviewedTrue && aCellContent.hasGotReward == NO);
  self.getRewardButton.hidden = !hiddenFlag;
}

#pragma mark - Actions

- (IBAction)deleteButtonOnClick:(UIButton *)aSender
{
  [self.delegate doQuestAction:kRPGQuestActionDeleteQuest
                        byType:kRPGQuestTypeSingle
                       questID:self.questID
                      friendID:-1];
}

- (IBAction)getRewardButtonOnClick:(UIButton *)aSender
{
  [self.delegate getRewardForQuestWithID:self.questID];
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

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)aGestureRecognizer
{
  BOOL result = NO;
  
  if ([aGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
  {

    UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer*)aGestureRecognizer;
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
  
  if (state == kRPGQuestStateCanTake
      || state == kRPGQuestStateInProgress
      || state == kRPGQuestStateReviewedFalse)
  {
    result = YES;
  }
  
  return result;
}

@end
