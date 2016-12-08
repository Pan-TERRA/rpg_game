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
  //Entities
#import "RPGCharacterProfileSkill.h"
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

- (void)moveItem:(RPGCharacterProfileSkill *)anItem type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      anItem.selected = !anItem.isSelected;
      break;
    }
      
    default:
    {
      break;
    }
  }
  
  [self.delegate reloadCollection:nil];
}

@end
