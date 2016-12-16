//
//  RPGArenaBagCollectionViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaBagCollectionViewController.h"

NSUInteger const kRPGArenaBagCollectionViewControllerCellInRow = 3;

@implementation RPGArenaBagCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return kRPGArenaBagCollectionViewControllerCellInRow;
}

- (NSUInteger)numberOfCellsInRow
{
  return kRPGArenaBagCollectionViewControllerCellInRow;
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
  [self.delegate addSkillToSkillCollectionWithID:anItemID];
}

@end
