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

- (BOOL)canSelectItem:(RPGCharacterProfileSkill *)anItem
{
  NSInteger requiredLevel = [RPGSkillRepresentation skillrepresentationWithSkillID:anItem.skillID].requiredLevel;
  RPGCharacterProfileViewController *characterProfileViewController = (RPGCharacterProfileViewController *)self.delegate;
  NSUInteger currentLevel = characterProfileViewController.characterLevel;
  
  return requiredLevel <= currentLevel;
}

- (void)moveItem:(RPGCharacterProfileSkill *)anItem type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      NSArray *validatedSkills = self.validatedSkills;
      
      if (!anItem.isSelected)
      {
        if ([self.delegate canAddToCollectionWithCurrentSize:validatedSkills.count])
        {
          RPGCharacterProfileSkill *skill = [validatedSkills lastObject];
          
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
