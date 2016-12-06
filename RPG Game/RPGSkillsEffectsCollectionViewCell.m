//
//  RPGSkillsEffectsCollectionViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillsEffectsCollectionViewCell.h"

@interface RPGSkillsEffectsCollectionViewCell()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *imageView;
@property (nonatomic, assign, readwrite) IBOutlet UIView *durationContainerView;
@property (nonatomic, assign, readwrite) IBOutlet UILabel *durationLabel;

@end

@implementation RPGSkillsEffectsCollectionViewCell

- (void)setImage:(UIImage *)anImage
{
  self.imageView.image = anImage;
}

- (UIImage *)image
{
  return self.imageView.image;
}

- (void)setDurationHidden:(BOOL)aDurationHiddenFlag
{
  self.durationContainerView.hidden = aDurationHiddenFlag;
}

- (BOOL)isDurationHidden
{
  return self.durationContainerView.hidden;
}

- (void)setDuration:(NSInteger)aDuration
{
  self.durationLabel.text = [NSString stringWithFormat:@"%ld", (long)aDuration];
}

- (NSInteger)duration
{
  return  [self.durationLabel.text integerValue];
}

@end
