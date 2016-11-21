  //
  //  RPGCollectionController.m
  //  RPG Game
  //
  //  Created by Максим Шульга on 11/17/16.
  //  Copyright © 2016 RPG-team. All rights reserved.
  //

#import "RPGCollectionViewController.h"
  // Controllers
#import "RPGSkillDescriptionViewController.h"
#import "RPGCharacterProfileViewController.h"
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
  // Entities
#import "RPGSkillRepresentation.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"
  // Constants
#import "RPGNibNames.h"

@interface RPGCollectionViewController() <UIGestureRecognizerDelegate>

@end

@implementation RPGCollectionViewController

#pragma mark - Init

- (instancetype)init
{
  self = [super init];
  
  if (self != nil)
  {
      //_skillsIDArray = [[NSMutableArray alloc] initWithObjects:@(1), @(5), @(3), @(4), nil];
  }
  
  return self;
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsID release];
  
  [super dealloc];
}

#pragma mark - Custom Setter

- (void)setCollectionView:(UICollectionView *)aCollectionView
{
  _collectionView = aCollectionView;
  UILongPressGestureRecognizer *gestureRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handleLongPress:)] autorelease];
  gestureRecognizer.delegate = self;
  gestureRecognizer.minimumPressDuration = 1;
  
  [self.collectionView addGestureRecognizer:gestureRecognizer];
}

- (void)setSkillsID:(NSMutableArray *)skillsIDArray
{
  if (_skillsID != skillsIDArray)
  {
    [_skillsID release];
    _skillsID = [skillsIDArray retain];
  }
  
  [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGCharacterBagCollectionViewCell *cell = [aCollectionView dequeueReusableCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName
                                                                                       forIndexPath:anIndexPath];
  
  NSInteger index = anIndexPath.row;
  if (index < self.collectionSize)
  {
    if (index < self.skillsID.count)
    {
      NSUInteger skillID = [self.skillsID[index] integerValue];
      RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
      
      if (skillRepresentation.imageName.length != 0)
      {
        cell.image = [UIImage imageNamed:skillRepresentation.imageName];
      }
      else
      {
          // default image for skills/items with no image
        cell.image = [UIImage imageNamed:@"battle_empty_icon_unset"];
      }
    }
    else
    {
        // unset skills or empty bag cells
      [cell setImage:[UIImage imageNamed:@"battle_empty_icon_inactive"]];
    }
  }
  else
  {
      // locked bag cells/skills
    [cell setImage:[UIImage imageNamed:@"battle_empty_icon_lock"]];
  }
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat viewWidth = self.collectionView.frame.size.width;
  CGFloat cellWidth = viewWidth * self.cellMultiplier;
  
  return CGSizeMake(cellWidth, cellWidth);
}

#pragma mark - Action Long Press

- (void)handleLongPress:(UILongPressGestureRecognizer *)aGestureRecognizer
{
  if (aGestureRecognizer.state == UIGestureRecognizerStateBegan)
  {
    CGPoint clickedPoint = [aGestureRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:clickedPoint];
    
    if (indexPath != nil)
    {
      NSInteger row = indexPath.row;
      if (row < self.skillsID.count)
      {
        NSUInteger skillID = [self.skillsID[row] integerValue];
        RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
        RPGSkillDescriptionViewController *skillDescriptionViewController = [RPGSkillDescriptionViewController viewControllerWithSkillRepresentation:skillRepresentation];
        
        RPGCharacterProfileViewController *parentViewController = self.viewController;
        [parentViewController addChildViewController:skillDescriptionViewController frame:parentViewController.view.frame];
      }
    }
  }
}

- (void)addItem:(NSUInteger)anItemID type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      if (self.skillsID.count >= self.collectionSize)
      {
        [self moveItem:[[self.skillsID lastObject] integerValue] type:kRPGItemTypeSkill];
      }
      [self.skillsID addObject:@(anItemID)];
      
      break;
    }
      
    default:
    {
      break;
    }
  }
  
  [self.collectionView reloadData];
}

- (void)removeItem:(NSUInteger)anItemID type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      [self.skillsID removeObject:@(anItemID)];
      
      break;
    }
      
    default:
    {
      break;
    }
  }
  
  [self.collectionView reloadData];
}

- (void)moveItem:(NSUInteger)anItemID type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      [self removeItem:anItemID type:aType];
      [self addItemToOtherCollectionWithID:anItemID type:aType];
      
      break;
    }
      
    default:
    {
      break;
    }
  }
  
  [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  NSInteger index = anIndexPath.row;
  
  if (index < self.skillsID.count)
  {
    NSUInteger skillID = [self.skillsID[index] integerValue];
    [self moveItem:skillID type:kRPGItemTypeSkill];
  }
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
    // Define move logic there
}

@end
