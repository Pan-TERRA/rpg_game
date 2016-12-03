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
  // Entities
#import "RPGSkillRepresentation.h"
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

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  NSInteger index = anIndexPath.row;
  
  if (index < self.skillsIDArray.count)
  {
    NSUInteger skillID = [self.skillsIDArray[index] integerValue];
    RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
    if (skillRepresentation.requiredLevel <= ((RPGCharacterProfileViewController *)self.viewController).characterLevel)
    {
      [self moveItem:skillID type:kRPGItemTypeSkill];
    }
  }
}

@end
