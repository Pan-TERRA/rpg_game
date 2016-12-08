//
//  RPGSkillsEffectsCollectionViewCell.h
//  RPG Game
//
//  Created by Максим Шульга on 12/6/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import <UIKit/UIKit.h>
  // Constants
#import "RPGSkillsEffectsCollectionViewAlign.h"

@interface RPGSkillsEffectsCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign, readwrite) UIImage *image;
@property (nonatomic, assign, readwrite) UIImage *backgroundImage;
@property (nonatomic, assign, readwrite) NSInteger duration;

@property (nonatomic, assign, readwrite) RPGSkillsEffectsCollectionViewAlign align;

@end
