//
//  RPGSkillCollectionController.m
//  RPG Game
//
//  Created by Максим Шульга on 11/17/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGSkillCollectionViewController.h"
#import "RPGCharacterBagCollectionViewCell.h"
#import "RPGCharacterProfileViewController.h"
#import "RPGNibNames.h"

NSUInteger const kRPGSkillCollectionViewControllerMaxSize = 5;
CGFloat const kRPGSkillCollectionViewControllerCellWidthMultiplier = 0.2;

@interface RPGSkillCollectionViewController()

@property (nonatomic, assign, readwrite) NSUInteger skillColectionSize;

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

- (void)setCollectionSize:(NSUInteger)aCollectionSize
{
  self.skillColectionSize = aCollectionSize;
}

-(void)addToOtherCollectionSkillWithID:(NSUInteger)aSkillID
{
  [self.viewController addToBagCollectionSkillWithID:aSkillID];
}

@end
