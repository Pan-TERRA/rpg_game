//
//  RPGSkillCollectionController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillCollectionViewController.h"
#import "RPGCharacterBagCollectionViewCell.h"
#import "RPGNibNames.h"
#import "RPGSkillRepresentation.h"

NSUInteger const kRPGSkillCollectionViewControllerMaxSize = 5;
CGFloat const kRPGSkillCollectionViewControllerCellWidthMultiplier = 0.2;

@interface RPGSkillCollectionViewController()

@end

@implementation RPGSkillCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return kRPGSkillCollectionViewControllerMaxSize;
}

- (CGFloat)cellMultiplier
{
  return kRPGSkillCollectionViewControllerCellWidthMultiplier;
}

- (NSUInteger)collectionSize
{
  return self.skillColectionSize;
}

@end
