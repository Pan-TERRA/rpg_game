//
//  RPGBagCollectionController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGBagCollectionViewController.h"
  // Controllers
#import "RPGCharacterProfileViewController.h"
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
  // Constants
#import "RPGNibNames.h"

NSUInteger const kRPGBagCollectionViewControllerCellInRow = 4;
CGFloat const kRPGBagCollectionViewControllerCellWidthMultiplier = 0.25;

@interface RPGBagCollectionViewController()

@property (nonatomic, assign, readwrite) NSUInteger bagCollectionSize;

@end

@implementation RPGBagCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.bagCollectionSize;
}

- (CGFloat)cellMultiplier
{
  return kRPGBagCollectionViewControllerCellWidthMultiplier;
}

- (NSUInteger)collectionSize
{
  return self.bagCollectionSize;
}

- (void)setCollectionSize:(NSUInteger)aCollectionSize
{
  self.bagCollectionSize = aCollectionSize;
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
  [self.viewController addSkillToSkillCollectionWithID:anItemID type:aType];
}

@end
