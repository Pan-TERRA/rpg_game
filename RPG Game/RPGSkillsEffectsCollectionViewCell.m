//
//  RPGSkillsEffectsCollectionViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsEffectsCollectionViewCell.h"

static CGFloat const kRPGSkillsEffectsCollectionViewControllerViewCornerRadiusMultiplier = 0.5;

@interface RPGSkillsEffectsCollectionViewCell()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *imageView;

@property (nonatomic, assign, readwrite) IBOutlet UIView *durationView;
@property (nonatomic, assign, readwrite) IBOutlet UIView *durationContainerView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *durationLabel;

@end

@implementation RPGSkillsEffectsCollectionViewCell

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  [self setCornerRadiusForView:self.backgroundImageView];
  [self setCornerRadiusForView:self.durationView];
}

#pragma mark - Accessors

- (void)setImage:(UIImage *)anImage
{
  self.imageView.image = anImage;
}

- (UIImage *)image
{
  return self.imageView.image;
}

- (void)setBackgroundImage:(UIImage *)anImage
{
  self.backgroundImageView.image = anImage;
}

- (UIImage *)backgroundImage
{
  return self.backgroundImageView.image;
}

- (void)setDuration:(NSInteger)aDuration
{
  self.durationLabel.text = [NSString stringWithFormat:@"%ld", (long)aDuration];
}

- (NSInteger)duration
{
  return [self.durationLabel.text integerValue];
}

- (void)setAlign:(RPGSkillsEffectsCollectionViewAlign)anAlign
{
  _align = anAlign;
  
  if (_align == kRPGSkillsEffectsCollectionViewAlignRight)
  {
    self.transform = CGAffineTransformMakeScale(-1, 1);
  }
}

#pragma mark - 

- (void)setCornerRadiusForView:(UIView *)aView
{
  aView.layer.cornerRadius = aView.frame.size.width * kRPGSkillsEffectsCollectionViewControllerViewCornerRadiusMultiplier;
  aView.layer.masksToBounds = YES;
}

@end
