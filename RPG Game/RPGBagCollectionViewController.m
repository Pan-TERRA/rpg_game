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
  // Constants
#import "RPGNibNames.h"

NSUInteger const kRPGBagCollectionViewControllerCellInRow = 4;

@implementation RPGBagCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.collectionSize;
}

- (NSUInteger)numberOfCellsInRow
{
  return kRPGBagCollectionViewControllerCellInRow;
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
  [(RPGCharacterProfileViewController *)self.viewController addSkillToSkillCollectionWithID:anItemID type:aType];
}

@end
