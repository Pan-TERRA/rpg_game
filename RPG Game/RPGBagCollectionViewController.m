//
//  RPGBagCollectionController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBagCollectionViewController.h"
#import "RPGCharacterBagCollectionViewCell.h"
#import "RPGCharacterProfileViewController.h"
#import "RPGNibNames.h"

NSUInteger const kRPGBagCollectionViewControllerCellInRow = 4;
CGFloat const kRPGBagCollectionViewControllerCellWidthMultiplier = 0.25;

@implementation RPGBagCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 8;
}

- (CGFloat)cellMultiplier
{
  return kRPGBagCollectionViewControllerCellWidthMultiplier;
}

- (NSUInteger)collectionSize
{
  return self.bagCollectionSize;
}

-(void)addToOtherCollectionSkillWithID:(NSUInteger)aSkillID
{
  [self.viewController addToSkillCollectionSkillWithID:aSkillID];
}

@end
