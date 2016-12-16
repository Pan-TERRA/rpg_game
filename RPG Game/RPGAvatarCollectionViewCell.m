//
//  RPGAvatarCollectionViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGAvatarCollectionViewCell.h"

@interface RPGAvatarCollectionViewCell()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *imageView;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView *chosenFlagImageView;

@end

@implementation RPGAvatarCollectionViewCell

- (void)setImage:(UIImage *)anImage
{
  self.imageView.image = anImage;
}

- (UIImage *)image
{
  return self.imageView.image;
}

- (void)setChosenFlagImageViewHidden:(BOOL)aHiddenFlag
{
  self.chosenFlagImageView.hidden = aHiddenFlag;
}

@end
