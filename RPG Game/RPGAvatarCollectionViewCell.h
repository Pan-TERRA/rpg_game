//
//  RPGAvatarCollectionViewCell.h
//  RPG Game
//
//  Created by Максим Шульга on 11/30/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPGAvatarCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign, readwrite) UIImage *image;

- (void)setChosenFlagImageViewHidden:(BOOL)aFlag;

@end
