//
//  RPGSkillCollectionController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillCollectionViewController.h"
  // Controllers
#import "RPGCharacterProfileViewController.h"
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
  // Constants
#import "RPGNibNames.h"

NSUInteger const kRPGSkillCollectionViewControllerMaxSize = 5;

@implementation RPGSkillCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return kRPGSkillCollectionViewControllerMaxSize;
}

- (NSUInteger)numberOfCellsInRow
{
  return kRPGSkillCollectionViewControllerMaxSize;
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
  [(RPGCharacterProfileViewController *)self.viewController addItemToBagCollectionWithID:anItemID type:aType];
}

@end
