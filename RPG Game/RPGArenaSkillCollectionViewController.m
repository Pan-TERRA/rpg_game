//
//  RPGArenaSkillCollectionViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaSkillCollectionViewController.h"

NSUInteger const kRPGArenaSkillCollectionViewControllerMaxSize = 5;

@implementation RPGArenaSkillCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return kRPGArenaSkillCollectionViewControllerMaxSize;
}

- (NSUInteger)numberOfCellsInRow
{
  return kRPGArenaSkillCollectionViewControllerMaxSize;
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
  return;
}

@end
