//
//  RPGCharacterBagCollectionViewCell.h
//  RPG Game
//
//  Created by Максим Шульга on 11/16/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPGCharacterBagCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic, readwrite) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, assign, readwrite) UIImage *image;

@end
