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
  // Views
#import "RPGCharacterBagCollectionViewCell.h"
  // Entities
#import "RPGSkillRepresentation.h"
#import "RPGCharacterProfileSkill.h"
  // Misc
#import "UIViewController+RPGChildViewController.h"
  // Constants
#import "RPGNibNames.h"

// Constants

NSInteger kRPGCollectionViewControllerSkillButtonCornerRadius = 25;

@interface RPGCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, assign, readwrite) UICollectionView *collectionView;
@property (nonatomic, retain, readwrite) NSMutableArray *skillsMutableArray;
@property (nonatomic, assign, readwrite, getter=shouldValidateSkillsArray) BOOL validateSkillsArray;

@end

@implementation RPGCollectionViewController

#pragma mark - Init

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSMutableArray *)aSkillsArray
{
  return [self initWithCollectionView:aCollectionView
                       collectionSize:aCollectionSize
                          skillsArray:aSkillsArray
        shouldUseValidatedSkillsArray:NO];
}

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSMutableArray *)aSkillsArray
         shouldUseValidatedSkillsArray:(BOOL)aValidateSkillsArrayFlag
{
  self = [super init];
  
  if (self != nil)
  {
    _collectionView = aCollectionView;
    UILongPressGestureRecognizer *gestureRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                     action:@selector(handleLongPress:)] autorelease];
    gestureRecognizer.delegate = self;
    gestureRecognizer.minimumPressDuration = 1;
    
    [_collectionView addGestureRecognizer:gestureRecognizer];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionSize = aCollectionSize;
    _skillsMutableArray = [aSkillsArray retain];
    _validateSkillsArray = aValidateSkillsArrayFlag;
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithCollectionView:nil
                       collectionSize:0
                          skillsArray:nil
        shouldUseValidatedSkillsArray:NO];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsMutableArray release];
  
  [super dealloc];
}

#pragma mark - Custom Getter

- (NSArray *)skillsIDArray
{
  NSMutableArray *skills = [NSMutableArray array];
  for (RPGCharacterProfileSkill *skill in self.validatedSkillsArray)
  {
    [skills addObject:@(skill.skillID)];
  }
  return skills;
}

- (NSArray *)skillsArray
{
  return self.skillsMutableArray;
}

- (NSArray *)validatedSkillsArray
{
  return [self validatedSkillsArray:self.shouldValidateSkillsArray];
}

- (BOOL)canSelectItem:(RPGCharacterProfileSkill *)anItem
{
  return YES;
}

#pragma mark - Heplful Method

- (NSArray *)validatedSkillsArray:(BOOL)aFlag
{
  NSArray *array = self.skillsArray;
  if (aFlag)
  {
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (RPGCharacterProfileSkill *skill in array)
    {
      if (skill.isSelected)
      {
        [mutableArray addObject:skill];
      }
    }
    array = mutableArray;
  }
  return array;
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
    NSArray *array = self.validatedSkillsArray;
    if (index < array.count)
    {
      RPGCharacterProfileSkill *skill = array[index];
      RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skill.skillID];
      
      if (skillRepresentation.imageName.length != 0)
      {
        
        if (skill.isSelected)
        {
          cell.image = [UIImage imageNamed:@"skill_selected"];
        }
        else
        {
          cell.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
        }
        cell.backgroundImageView.image = [UIImage imageNamed:skillRepresentation.imageName];
        cell.backgroundImageView.layer.cornerRadius = kRPGCollectionViewControllerSkillButtonCornerRadius;
        cell.backgroundImageView.layer.masksToBounds = YES;
      }
      else
      {
          // default image for skills/items with no image
        cell.image = [UIImage imageNamed:@"battle_empty_icon_unset"];
        cell.backgroundImageView.image = nil;
      }
    }
    else
    {
        // unset skills or empty bag cells
      [cell setImage:[UIImage imageNamed:@"battle_empty_icon_inactive"]];
      cell.backgroundImageView.image = nil;
    }
  }
  else
  {
      // locked bag cells/skills
    [cell setImage:[UIImage imageNamed:@"battle_empty_icon_lock"]];
    cell.backgroundImageView.image = nil;
  }
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat viewWidth = self.collectionView.frame.size.width;
  CGFloat cellWidth = viewWidth / (CGFloat) self.numberOfCellsInRow;
  
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
      NSArray *array = self.validatedSkillsArray;
      if (row < array.count)
      {
        RPGCharacterProfileSkill *skill = array[row];
        RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skill.skillID];
        RPGSkillDescriptionViewController *skillDescriptionViewController = [RPGSkillDescriptionViewController viewControllerWithSkillRepresentation:skillRepresentation];
        
        UIViewController *parentViewController = (UIViewController *)self.delegate;
        [parentViewController addChildViewController:skillDescriptionViewController frame:parentViewController.view.frame];
      }
    }
  }
}

- (void)moveItem:(RPGCharacterProfileSkill *)anItem type:(RPGItemType)aType
{
  
  [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  NSInteger index = anIndexPath.row;
  NSArray *array = self.validatedSkillsArray;
  if (index < array.count)
  {
    RPGCharacterProfileSkill *skill = array[index];
    if ([self canSelectItem:skill])
    {
      [self moveItem:skill type:kRPGItemTypeSkill];
    }
  }
}

@end
