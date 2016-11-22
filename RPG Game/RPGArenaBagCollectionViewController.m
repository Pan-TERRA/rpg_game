//
//  RPGArenaBagCollectionViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaBagCollectionViewController.h"
#import "RPGArenaSkillDrawViewController.h"

NSUInteger const kRPGBagCollectionViewControllerCellInRow = 3;

@implementation RPGArenaBagCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return kRPGBagCollectionViewControllerCellInRow;
}

- (NSUInteger)numberOfCellsInRow
{
  return kRPGBagCollectionViewControllerCellInRow;
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
  RPGArenaSkillDrawViewController *parentViewController = (RPGArenaSkillDrawViewController *)self.viewController;
  [parentViewController addSkillToSkillCollectionWithID:anItemID];
}

@end
