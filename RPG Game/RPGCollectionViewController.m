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
  // Misc
#import "UIViewController+RPGChildViewController.h"
  // Constants
#import "RPGNibNames.h"

// Constants

static NSInteger kRPGCollectionViewControllerSkillButtonCornerRadius = 25;

@interface RPGCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, assign, readwrite) UIViewController *viewController;
@property (nonatomic, assign, readwrite) UICollectionView *collectionView;
@property (nonatomic, retain, readwrite) NSMutableArray *skillsIDMutableArray;

@end

@implementation RPGCollectionViewController

#pragma mark - Init

- (instancetype)initWithCollectionView:(UICollectionView *)aCollectionView
                  parentViewController:(UIViewController *)aViewController
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
    gestureRecognizer.minimumPressDuration = 1;
    
    [_collectionView addGestureRecognizer:gestureRecognizer];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _viewController = aViewController;
    _collectionSize = aCollectionSize;
    _skillsIDMutableArray = [aSkillsArray mutableCopy];
  }
  
  return self;
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
      if (row < self.skillsIDArray.count)
      {
        NSUInteger skillID = [self.skillsIDArray[row] integerValue];
        RPGSkillRepresentation *skillRepresentation = [RPGSkillRepresentation skillrepresentationWithSkillID:skillID];
        RPGSkillDescriptionViewController *skillDescriptionViewController = [RPGSkillDescriptionViewController viewControllerWithSkillRepresentation:skillRepresentation];
        
        UIViewController *parentViewController = self.viewController;
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

- (void)removeItem:(NSUInteger)anItemID type:(RPGItemType)aType
{
  switch (aType)
  {
    case kRPGItemTypeSkill:
    {
      [self.skillsIDMutableArray removeObject:@(anItemID)];
      
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
  
  if (index < self.skillsIDArray.count)
  {
    NSUInteger skillID = [self.skillsIDArray[index] integerValue];
    [self moveItem:skillID type:kRPGItemTypeSkill];
  }
}

- (void)addItemToOtherCollectionWithID:(NSUInteger)anItemID type:(RPGItemType)aType
{
    // Define move logic there
}

@end
