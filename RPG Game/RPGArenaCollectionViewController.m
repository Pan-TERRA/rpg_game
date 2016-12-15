//
//  RPGArenaCollectionViewController.m
//  RPG Game
//
//  Created by Костянтин Паляничко on 11/21/16.
//  Copyright © 2016 RPG-team. All rights reserved.
//

#import "RPGArenaCollectionViewController.h"

//@implementation RPGArenaCollectionViewController
//
///**
// *  Swaps item to another collection.
// *  This method is invoked by superclass, when user taps a skill in collection
// *
// *  @param anItemID An item identifier
// *  @param aType    Type of an item
// */
//- (void)moveItem:(NSUInteger)anItemID type:(RPGItemType)aType
//{
//  [self addItemToOtherCollectionWithID:anItemID type:aType];
//}

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

static NSInteger kRPGCollectionViewControllerSkillButtonCornerRadius = 25;

@interface RPGArenaCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, assign, readwrite) UICollectionView *collectionView;
@property (nonatomic, retain, readwrite) NSMutableArray *skillsIDMutableArray;

@end

@implementation RPGArenaCollectionViewController

#pragma mark - Init

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                        collectionSize:(NSUInteger)aCollectionSize
                           skillsArray:(NSArray *)aSkillsArray
{
  self = [super init];
  
  if (self != nil)
  {
    _collectionView = aCollectionView;
    UILongPressGestureRecognizer *gestureRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                     action:@selector(handleLongPress:)] autorelease];
    gestureRecognizer.delegate = self;
    gestureRecognizer.minimumPressDuration = 0.5;
    
    [_collectionView addGestureRecognizer:gestureRecognizer];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionSize = aCollectionSize;
    _skillsIDMutableArray = [aSkillsArray mutableCopy];
  }
  
  return self;
}

- (instancetype)init
{
  return [self initWithCollectionView:nil
                       collectionSize:0
                          skillsArray:nil];
}

#pragma mark - Dealloc

- (void)dealloc
{
  [_skillsIDMutableArray release];
  
  [super dealloc];
}

#pragma mark - Custom Getter

- (NSArray *)skillsIDArray
{
  return self.skillsIDMutableArray;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
  return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  RPGCharacterBagCollectionViewCell *cell = [aCollectionView
                                             dequeueReusableCellWithReuseIdentifier:kRPGCharacterBagCollectionViewCellNIBName
                                             forIndexPath:anIndexPath];
  
  NSInteger index = anIndexPath.row;
  if (index < self.collectionSize)
  {
    if (index < self.skillsIDArray.count)
    {
      NSUInteger skillID = [self.skillsIDArray[index] integerValue];
      RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
      
      if (skillRepresentation.imageName.length != 0)
      {
        cell.image = [UIImage imageNamed:@"battle_empty_icon_inactive"];
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

- (CGSize)collectionView:(UICollectionView *)aCollectionView
                  layout:(UICollectionViewLayout *)aCollectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)anIndexPath
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
      if (row < self.skillsIDArray.count)
      {
        NSUInteger skillID = [self.skillsIDArray[row] integerValue];
        RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
        RPGSkillDescriptionViewController *skillDescriptionViewController = [[[RPGSkillDescriptionViewController alloc] init] autorelease];
        
        UIViewController *parentViewController = [self.delegate getViewController];
        [parentViewController addChildViewController:skillDescriptionViewController
                                               frame:parentViewController.view.frame];
        
        [skillDescriptionViewController setViewContent:skillRepresentation];
      }
    }
  }
}

- (void)addItem:(NSUInteger)anItemID
           type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      if (self.skillsIDArray.count >= self.collectionSize)
      {
        [self moveItem:[[self.skillsIDArray lastObject] integerValue] type:kRPGItemTypeSkill];
      }
      [self.skillsIDMutableArray addObject:@(anItemID)];
      
      break;
    }
      
    default:
    {
      break;
    }
  }
  
  [self.collectionView reloadData];
}

- (void)moveItem:(NSUInteger)anItemID
            type:(RPGItemType)aType
{
  [self addItemToOtherCollectionWithID:anItemID
                                  type:aType];
}

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)anIndexPath
{
  NSInteger index = anIndexPath.row;
  
  if (index < self.skillsIDArray.count)
  {
    NSUInteger skillID = [self.skillsIDArray[index] integerValue];
    [self moveItem:skillID type:kRPGItemTypeSkill];
  }
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID
                                  type:(RPGItemType)aType
{
  // Define move logic there
}

@end
