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
#import "RPGCharacterProfileSkill.h"
  // Constants
#import "RPGNibNames.h"

static NSUInteger const kRPGBagCollectionViewControllerCellInRow = 4;

@implementation RPGBagCollectionViewController

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
  return self.collectionSize;
}

- (NSUInteger)numberOfCellsInRow
{
  return kRPGBagCollectionViewControllerCellInRow;
}

- (BOOL)canSelectItem:(RPGCharacterProfileSkill *)anItem
{
  RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:anItem.skillID];
  return (skillRepresentation.requiredLevel <= ((RPGCharacterProfileViewController *)self.delegate).characterLevel);
}

- (void)moveItem:(RPGCharacterProfileSkill *)anItem
            type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      NSArray *array = [self validatedSkillsArray:YES];
      
      if (!anItem.isSelected)
      {
        if (![self.delegate canAddToCollectionWithCurrentSize:array.count])
        {
          RPGCharacterProfileSkill *skill = [array lastObject];
          skill.selected = !skill.isSelected;
        }
      }
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
