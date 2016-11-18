//
//  RPGCharacterBagCollectionViewCell.m
//  RPG Game
//
//  Created by Максим Шульга on 11/16/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGCharacterBagCollectionViewCell.h"

@interface RPGCharacterBagCollectionViewCell()

@property (nonatomic, assign, readwrite) IBOutlet UIImageView *imageView;

@end

@implementation RPGCharacterBagCollectionViewCell

- (void)setImage:(UIImage *)anImage
{
  self.imageView.image = anImage;
}

@end
